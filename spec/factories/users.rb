FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    iduff { "#{Faker::Number.number(digits: 11)}" }
    active { true }
    admin { false } 

    trait :is_admin do
      admin { true }
    end
  
    trait :inactive do
      active { false }
    end
  end


end
