FactoryBot.define do
  factory :waypoint do
    address {Faker::Address.street_address}
    city {Faker::Address.city }
    neighborhood {Faker::Address.community}
    is_college {false}
    kind {:stop}
  end

  trait :college do
    is_college {true}
  end
  trait :destination do
    kind {:destination}
    order {0}
  end
  trait :departure do 
    kind {:departure}
    order {0}
  end
  
end
