require 'rails_helper'

RSpec.feature 'Caronas', type: :feature, js: true do
  let!(:admin){ create(:user, :is_admin, iduff: '00000000000') }
  let!(:user){ create(:user, iduff: '00000000001', name: "Usuário Teste") }
  let!(:college){ create(:college, neighborhood: "Inga") }

  describe 'Listar minhas caronas' do
    before do
      login_user(admin)
    end
    context 'com caronas cadastradas' do
      it 'deve mostrar corridas disponiveis' do
        ride = create(:ride, 
          departure_neighborhood: college.neighborhood, 
          college_id: college.id,
          driver_id: user.id
        )

        create(:waypoint, 
          :departure, 
          :college,
          neighborhood: college.neighborhood, 
          ride_id: ride.id
        )
        create(:waypoint,
          :destination,
          ride_id: ride.id
        )

        visit(user_rides_path(user))
        expect(page.evaluate_script("document.querySelector('section > ul').children.length")).to eq(user.rides.length)
      end

      xit 'devem estar ordenadas' do
        2.times do
          ride = create(:ride, 
            departure_neighborhood: college.neighborhood, 
            college_id: college.id, driver_id: user.id)
          create(:waypoint,:departure, :college,
            neighborhood: college.neighborhood, ride_id: ride.id)
          create(:waypoint, :destination, ride_id: ride.id)
        end

        visit(user_rides_path(user))
        rides = find('section > ul')
        result = page.evaluate_script(<<~JS)
          (function(){
            const rides = document.querySelector('section > ul');
            first_ride = rides.children[0];
            let date1 = new Date(first_ride.querySelector('#date').innerHTML.slice(6,14)+"T"+first_ride.querySelector('#date').innerHTML.slice(17,22));
            second_ride = rides.children[1];
            let date2 = new Date(second_ride.querySelector('#date').innerHTML.slice(6,14)+"T"+second_ride.querySelector('#date').innerHTML.slice(17,22));
            return date1 < date2
          })(arguments[0], arguments[1])
        JS
        expect(result).to be(false)

      end
    end
  end
end