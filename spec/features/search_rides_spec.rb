require 'rails_helper'

RSpec.feature 'Caronas', type: :feature, js: true do
  let!(:admin){ create(:user, :is_admin) }
  let!(:college){ create(:college) }
  let!(:neighborhood) { college.neighborhood.gsub(' ', '+') }
  let(:driver) { create(:user)}


  describe 'Pesquisar uma carona' do
    before do
      login_user(admin)
      visit(search_rides_path)
    end

    context 'com origem em um campus' do
      before (:each) do
        choose('departure_kind')
        select(college.neighborhood, from: 'college-select')
      end

      it 'deve deixar o botão de pesquisa disponivel' do
        expect(page.evaluate_script("document.querySelector('#commit-btn').disabled")).to eq(false)    
      end

      it 'deve realizar a pesquisa via query params' do
        click_button('Procurar')
        path = "/rides?departure_kind=college&ride%5Bneighborhood%5D=#{neighborhood}&destination=&commit=Procurar"
        expect(page).to have_current_path(path)
      end

      it 'deve retornar caronas com origem certa' do
        5.times do 
          ride = create(:ride, 
            college_id: college.id, 
            driver_id: driver.id, 
            departure_neighborhood: college.neighborhood
          )
          create(:waypoint, :college, :departure, 
            neighborhood: college.neighborhood,
            ride_id: ride.id
          )
          waypoint = create(:waypoint, :destination, ride_id: ride.id)
          ride.update(destination_neighborhood: waypoint.neighborhood)
        end
        page.save_screenshot('search-ride.png')
        click_button('Procurar')
        list = []
        page.all(:css, '.departure-name').each do |el|
          list << el.text.split(',')[1].strip
        end
        page.save_screenshot('search-ride(result).png')
        expect(list).to include(/#{college.neighborhood}/).exactly(5).times
      end

      context 'com destino em lugar aleatório' do
        it 'deve ter path com origem em campus e destino aleatório' do
          destination = Faker::Address.community
          fill_in('destination', with: destination)
          click_button('Procurar')
          path = "/rides?departure_kind=college&ride%5Bneighborhood%5D=#{neighborhood}&destination=#{destination.gsub(' ', '+')}&commit=Procurar"
          expect(page).to have_current_path(path)
        end
      end
    end

    context 'com destino para um campus' do
      before (:each) do
        choose('destination_kind')
        select(college.neighborhood, from: 'college-select')
      end

      it 'deve deixar o botão de pesquisa disponivel' do
        expect(find_button('Procurar').disabled?).to eq(false)    
      end

      it 'deve realizar a pesquisa via query params' do
        click_button('Procurar')
        path = "/rides?departure=&destination_kind=college&ride%5Bneighborhood%5D=#{neighborhood}&commit=Procurar"
        expect(page).to have_current_path(path)
      end

      it 'deve retornar caronas com destino certa' do
        5.times do 
          ride = create(:ride, :to_college, 
            college_id: college.id, 
            driver_id: driver.id,
            destination_neighborhood: college.neighborhood
          )
          create(:waypoint, :college, :destination, 
            neighborhood: college.neighborhood,
            ride_id: ride.id
          )
          waypoint = create(:waypoint, :departure, ride_id: ride.id)
          ride.update(departure_neighborhood: waypoint.neighborhood)
        end

        click_button('Procurar')
        list = []
        page.all(:css, '.destination-name').each {|el| list << el.text.split(',')[1].strip}
        expect(list).to include(/#{college.neighborhood}/).exactly(5).times
      end

      context 'com origem um lugar aleatório' do
        it 'deve ter path com origem aleatória e destino em campus' do
          departure = Faker::Address.community
          fill_in('departure', with: departure)
          click_button('Procurar')
          path = "/rides?departure=#{departure.gsub(' ', '+')}&destination_kind=college&ride%5Bneighborhood%5D=#{neighborhood}&commit=Procurar"
          expect(page).to have_current_path(path)
        end
      end
    end

    context 'sem destino e nem origem em campus' do
      it 'deve deixar o botão pesquisa indisponivel' do
        expect(page.evaluate_script("document.querySelector('#commit-btn').disabled")).to eq(true)
      end
    end
  end
end