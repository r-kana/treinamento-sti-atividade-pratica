FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    cpf { "#{Faker::Number.number(digits: 11)}" }
    active { true }
    admin { false } 
    password { "#{Faker::Number.number(digits: 8)}" }

    trait :is_admin do
      admin { true }
    end
  
    trait :inactive do
      active { false }
    end
  end


end
