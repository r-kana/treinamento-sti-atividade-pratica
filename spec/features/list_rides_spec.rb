require 'rails_helper'

RSpec.feature 'Caronas', type: :feature, js: true do
  let!(:admin){ create(:user, :is_admin, iduff: '00000000000') }
  let!(:user){ create(:user, iduff: '00000000001', name: "Usuário Teste") }
  let!(:aux_user){ create(:user, iduff: '00000000002', name: "Usuário Auxiliar") }
  let!(:college){ create(:college, neighborhood: "Inga") }

  describe 'Listar minhas caronas' do
    before do
      login_user(user)
    end
    context 'com caronas cadastradas' do
      it 'deve mostrar corridas disponiveis' do
        5.times do
          ride = create(:ride, 
            departure_neighborhood: college.neighborhood, 
            college_id: college.id, driver_id: user.id)
          create(:waypoint,:departure, :college,
            neighborhood: college.neighborhood, ride_id: ride.id)
          create(:waypoint, :destination, ride_id: ride.id)
        end

        visit(user_rides_path(user))
        expect(page.evaluate_script("document.querySelector('section > ul').children.length")).to eq(user.rides.length)
      end

      it 'devem estar ordenadas' do
        5.times do
          ride = create(:ride, 
            departure_neighborhood: college.neighborhood, 
            college_id: college.id, driver_id: user.id)
          create(:waypoint,:departure, :college,
            neighborhood: college.neighborhood, ride_id: ride.id)
          create(:waypoint, :destination, ride_id: ride.id)
        end

        visit(user_rides_path(user))

        previous = nil
        in_order = true
        page.all(:css, '.ride-date').each do |el|
          current = to_date_time(el.text)
          if previous and previous > current
            in_order = false
            break
          else 
            previous = to_date_time(el.text)
          end
        end

        expect(in_order).to be(true)

      end

      it 'devem ser todas do usuário' do
        5.times do
          ride = create(:ride, 
            departure_neighborhood: college.neighborhood, 
            college_id: college.id, driver_id: user.id)
          create(:waypoint,:departure, :college,
            neighborhood: college.neighborhood, ride_id: ride.id)
          create(:waypoint, :destination, ride_id: ride.id)

          ride = create(:ride, 
            departure_neighborhood: college.neighborhood, 
            college_id: college.id, driver_id: aux_user.id)
          create(:waypoint,:departure, :college,
            neighborhood: college.neighborhood, ride_id: ride.id)
          create(:waypoint, :destination, ride_id: ride.id)
        end

        visit(user_rides_path(user))
        list = []
        page.all(:css, '.driver-name').each {|el| list << el.text.split(':').last.strip }
        expect(list).to include(/#{user.name}/).exactly(5).times
      end
    end
  end

  def to_date_time s
    raw = s.split()
    parts = raw[1].split('-')
    date = "20#{parts[2]}-#{parts[1]}-#{parts[0]}"
    date_time = DateTime.parse("#{date}T#{raw[3]}")
  end

end