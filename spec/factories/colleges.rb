FactoryBot.define do
  factory :college do
    name {Faker::IndustrySegments.sector}
    phone_number {"#{Faker::Number.number(digits: 2)}#{Faker::Number.number(digits: 4)}-#{Faker::Number.number(digits: 4)}"}
    address {Faker::Address.street_address}
    neighborhood {Faker::Address.community} 
    city {Faker::Address.city}
    cep {"#{Faker::Number.number(digits: 5)}-#{Faker::Number.number(digits: 3)}"}
    
    trait :inactive do 
      active {false}
    end
  end
end
