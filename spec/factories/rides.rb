FactoryBot.define do
  factory :ride do
    observation { Faker::Lorem.paragraph }
    seats { 4 }
    number_of_passagers { 0 } 
    date { Date.today + Faker::Number.between(from: 1, to: 10) }
    time { Time.now + Faker::Number.between(from: 1800, to: 3600) }
    to_college { false }
    full { false }
    active { true }
    price { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
  end

  trait :to_college do 
    to_college { true }
  end

  trait :almost_full do
    number_of_passagers { 3 }
  end

  trait :full do
    number_of_passagers { 4 }
  end

end
