require 'rails_helper'

RSpec.describe Ride, type: :model do

  let! (:college) { create(:college) }
  let! (:driver) { create(:user) }
  let! (:full_query) {{ destination: "Bairro Destino", departure: "Bairro Origem" }}
  let! (:departure_query) {{ departure: "Bairro Origem" }}
  let! (:destination_query) {{ destination: "Bairro Destino" }}
  let! (:empty_query) {{}}
  let (:create_rides) {
    create_list(:ride, 5,
    destination_neighborhood: "Bairro Destino", 
    departure_neighborhood: "Bairro Origem",
    driver: driver,
    college_id: college.id)
  }

  context 'when a user searches' do
    context 'given destination and departure' do
      it 'should return rides with same params' do
        create_rides
        expect(Ride.search(full_query).length).to eq(create_rides.length)
      end

      it 'should return rides with same departure' do
        create_rides
        rides = Ride.search(departure_query)
        expect(rides.length).to eq(create_rides.length)
        expect(rides.first.departure_neighborhood).to eq("Bairro Origem")
      end

      it 'should return rides with same destination' do
        create_rides
        rides = Ride.search(destination_query)
        expect(rides.length).to eq(create_rides.length)
        expect(rides.first.destination_neighborhood).to eq("Bairro Destino")
      end

      context 'and ride to a college' do
        it 'should have a destination as a college' do
          ride = create(:ride, :to_college, driver: driver, college_id: college.id)
          waypoint = create(:waypoint, 
            :destination, 
            :college, 
            ride: ride, 
            address: college.address, 
            neighborhood: college.neighborhood, 
            city: college.city)
          ride.update(destination_neighborhood: waypoint.neighborhood)

          rides = Ride.search({destination: college.neighborhood}).first
          expect(rides.destination.kind).to eq('destination')
          expect(rides.destination.is_college).to eq(true)
        end
      end 
    end
    context 'given no params' do
      it 'should return all available rides' do
        create_list(:ride, 5, driver: driver, college_id: college.id)
        expect(Ride.search(empty_query).length).to eq(5)
      end
    end
  end

  context 'when booking' do
    context 'a non full ride:' do

      it 'should add 1 to the number of passagens' do
        ride = create(:ride, driver: driver, college_id: college.id)
        expect{ ride.book_seat }.to change(ride, :number_of_passagers).by(1)
      end

      it 'should be full if equals the number o seat' do
        ride = create(:ride, :almost_full, driver: driver, college_id: college.id)
        expect{ ride.book_seat }.to change(ride, :full).from(false).to(true)
      end

      it 'should return true' do
        ride = create(:ride, :almost_full, driver: driver, college_id: college.id)
        expect(ride.book_seat).to be(true)
      end
    end
    context 'a full ride:' do
      it 'should return false' do
        ride = create(:ride, :full, driver: driver, college_id: college.id)
        expect(ride.book_seat).to be(false)
      end

      it 'should includes error' do
        ride = create(:ride, :full, driver: driver, college_id: college.id)
        ride.book_seat
        expect(ride.errors[:number_of_passagers]).to include("can't be greater than seats")
      end
    end
  end

  context 'when creating' do
    context 'with valid parameters:' do
      it 'should be valid' do
        ride = build(:ride, driver: driver, college_id: college.id)
        expect(ride.valid?).to be(true)
      end
    end
    context 'with missing parameters:' do
      it 'should be invalid without date' do
        ride = build(:ride, date: nil, driver: driver, college_id: college.id)
        expect(ride.valid?).to be(false)
      end
      it 'should be invalid without time' do
        ride = build(:ride, time: nil, driver: driver, college_id: college.id)
        expect(ride.valid?).to be(false)
      end
      it 'should be invalid without to_college' do
        ride = build(:ride, to_college: nil, driver: driver)
        expect(ride.valid?).to be(false)
      end
      it 'should be invalid without driver_id' do
        ride = build(:ride)
        expect(ride.valid?).to be(false)
      end
      it 'should be invalid without college_id' do
        ride = build(:ride, driver: driver)
        expect(ride.valid?).to be(false)
      end
    end
  end
end
