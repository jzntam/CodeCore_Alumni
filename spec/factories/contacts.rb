FactoryGirl.define do
  factory :contact do
    phone Faker::PhoneNumber.phone_number
  end

end