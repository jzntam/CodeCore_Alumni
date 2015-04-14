FactoryGirl.define do
  factory :cohort do
    sequence(:title) { |n| " #{Faker::Company.name}-#{n}"}
    details Faker::Company.catch_phrase
  end  
end