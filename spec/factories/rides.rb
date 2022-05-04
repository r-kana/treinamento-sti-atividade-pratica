FactoryBot.define do
  factory :ride do
    observation {Faker::Lorem.paragraph}
    seats {4}
    number_of_passagers {0}
    date {Date.today}
    time {Time.now}
    to_college {true}
    full {false}
    active {true}
  end
end
