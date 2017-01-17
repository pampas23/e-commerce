FactoryGirl.define do
  factory :user do
		email "admin@gmail.com"
    password "12345678"
    factory :admin_user do
    	role "admin"	
    end
    factory :general_user do
    	role "general"	
    end    
  end
end
