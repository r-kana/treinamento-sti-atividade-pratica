FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    cpf { "#{Faker::Number.number(digits: 3)}.#{Faker::Number.number(digits: 3)}.#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 2)}" }
    iduff { "#{Faker::Name.first_name.downcase}@id.uff.br" }
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
