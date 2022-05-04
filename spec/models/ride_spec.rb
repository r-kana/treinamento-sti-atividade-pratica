require 'rails_helper'

RSpec.describe Ride, type: :model do

  let (:college) {create(:college)}
  let (:driver) {create(:user)}
  let (:college_waypoint) {create(:waypoint, :college)}
  let (:query) { {destination: "Bairro Destino", departure: "Bairro Origem"} }
  let (:empty_query) { {} }

  context 'when a user search for a ride' do
    context 'when given destination and departure params' do
      it 'should return rides with same params' do
        create_list(:ride, 5,
                    destination_neighborhood: "Bairro Destino", 
                    departure_neighborhood: "Bairro Origem",
                    driver: create(:user))

        expect(Ride.search(query).length).to eq(5)
      end
    end
    context 'when given no params' do
      it 'should return all available rides' do
        rides = create_list(:ride, 5, driver: create(:user))
        expect(Ride.search(empty_query).length).to eq(5)
      end
    end
  end
end
