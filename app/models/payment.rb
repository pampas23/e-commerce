class Payment < ApplicationRecord
   serialize :params, JSON
 
   belongs_to :order
 
   before_validation :setup_amount
   after_update :update_order_status
 
   PAYMENT_METHODS = %w[Credit WebATM ATM] # CVS BARCODE
   validates_inclusion_of :payment_method, :in => PAYMENT_METHODS
 
   validate :check_mac, on: :update
 
   def deadline
     Time.now + 7.days
   end
 
   def name
     "ALPHACamp AC6 Order: #{self.order.id}"
   end
 
   def email
     order.email
   end
 
   def external_id
     "#{self.id}AC#{Rails.env.upcase[0]}"
   end
 
   def self.find_and_process(params)
     result = JSON.parse( params['Result'] )
 
     payment = self.find(result['MerchantOrderNo'].to_i)
     payment.paid = params['Status'] == 'SUCCESS'
     payment.params = params
     payment
   end
 
   def parse_result
     JSON.parse( self.params['Result'] )
   end
 
   def check_mac
     pay2go = Pay2go.new(parse_result)
     errors.add(:params, 'wrong mac value') unless pay2go.check_mac
   end
    
   def pay2go_params
    pay2go_params = {
      MerchantID: Pay2go.merchant_id,
      RespondType: "JSON",
      TimeStamp: created_at.to_i,
      Version: "1.2",
      LangType: 'zh-tw', #I18n.locale.downcase, # zh-tw or en
      MerchantOrderNo: external_id,
      Amt: amount,
      ItemDesc: name,
      ReturnURL: pay2go_return_path,
      NotifyURL: Pay2go.notify_url,
      Email: email,
      LoginType: 0,
      CREDIT: 0,
      WEBATM: 0,
      VACC: 0,
      CVS: 0,
      BARCODE: 0
    }

    case payment_method
      when "Credit"
        pay2go_params.merge!( :CREDIT => 1 )
      when "WebATM"
        pay2go_params.merge!( :WEBATM => 1 )
      when "ATM"
        pay2go_params.merge!( :VACC => 1, :ExpireDate => payment.deadline.strftime("%Y%m%d") )
      when "CVS"
        pay2go_params.merge!( :CVS => 1, :ExpireDate => payment.deadline.strftime("%Y%m%d") )
      when "BARCODE"
        pay2go_params.merge!( :BARCODE => 1, :ExpireDate => payment.deadline.strftime("%Y%m%d") )
    end

    pay2go = Pay2go.new(pay2go_params)
    pay2go_params[:CheckValue] = pay2go.make_check_value
    pay2go_params
  end

   private
    
   def pay2go_return_path
     
   end
   def setup_amount
     self.amount = order.amount
   end
 
   def update_order_status
     if self.paid && !self.order.paid?
       order.paid = true
       order.save( :validate => false )
     end
   end
end
