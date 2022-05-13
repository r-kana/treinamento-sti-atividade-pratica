require 'faker'

admin = User.create!(name: 'Admin', cpf: '11111111110', admin: true, active: true, password: '123')
user = User.create!(name: 'User', cpf: '11111111114', admin: false, active: true, password: '123')
college = College.create!(
  name: Faker::IndustrySegments.sector,
  phone_number: "#{Faker::Number.number(digits: 2)}#{Faker::Number.number(digits: 4)}-#{Faker::Number.number(digits: 4)}",
  address: Faker::Address.street_address,
  neighborhood: Faker::Address.community,
  city: Faker::Address.city,
  cep: "#{Faker::Number.number(digits: 5)}-#{Faker::Number.number(digits: 3)}"
)

5.times {
  College.create!(
    name: Faker::IndustrySegments.sector,
    phone_number: "#{Faker::Number.number(digits: 2)}#{Faker::Number.number(digits: 4)}-#{Faker::Number.number(digits: 4)}",
    address: Faker::Address.street_address,
    neighborhood: Faker::Address.community,
    city: Faker::Address.city,
    cep: "#{Faker::Number.number(digits: 5)}-#{Faker::Number.number(digits: 3)}"
  )
}


5.times {
  ride = Ride.create!(
    observation: Faker::Lorem.paragraph,
    seats: 4,
    number_of_passagers: 0,
    date: Date.today + 1,
    time: Time.now,
    to_college: true,
    full: false,
    active: true,
    price: Faker::Number.decimal(l_digits: 2, r_digits: 2),
    driver_id: user.id,
    college_id: college.id
  )
  departure = Waypoint.create!(
    address: Faker::Address.street_address,
    neighborhood: Faker::Address.community,
    city: Faker::Address.city,
    order: 0,
    kind: 'departure',
    ride_id: ride.id,
    is_college: false
  )
  destination = Waypoint.create!(
    address: college.address,
    neighborhood: college.neighborhood,
    city: college.city,
    order: 0,
    kind: 'destination',
    ride_id: ride.id,
    is_college: true
  )
  ride.update(
    departure_neighborhood: departure.neighborhood, 
    destination_neighborhood: destination.neighborhood
  )

  3.times {|i|
    waypoint = Waypoint.create!(
      address: Faker::Address.street_address,
      neighborhood: Faker::Address.community,
      city: Faker::Address.city,
      order: i+1,
      kind: 'stop',
      ride_id: ride.id,
      is_college: false
    )
  }
}