require 'rails_helper'

RSpec.feature 'Caronas', type: :feature, js: true do
  let!(:admin){ create(:user, :is_admin, cpf: '00000000000') }
  let!(:college){ create(:college, neighborhood: "Inga") }

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
        expect(page).to have_current_path("/rides?departure_kind=college&ride%5Bneighborhood%5D=#{college.neighborhood}&destination=&commit=Procurar")
      end

      context 'com destino em lugar aleatório' do
        it 'deve ter path com origem em campus e destino aleatório' do
          destination_neighborhood = "Centro"
          fill_in('destination', with: destination_neighborhood)
          click_button('Procurar')
          path = "/rides?departure_kind=college&ride%5Bneighborhood%5D=#{college.neighborhood}&destination=#{destination_neighborhood}&commit=Procurar"
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
        path = "/rides?departure=&destination_kind=college&ride%5Bneighborhood%5D=#{college.neighborhood}&commit=Procurar"
        expect(page).to have_current_path(path)
      end

      context 'com origem um lugar aleatório' do
        it 'deve ter path com origem aleatória e destino em campus' do
          departure_neighborhood = "Centro"
          fill_in('departure', with: departure_neighborhood)
          click_button('Procurar')
          path = "/rides?departure=#{departure_neighborhood}&destination_kind=college&ride%5Bneighborhood%5D=#{college.neighborhood}&commit=Procurar"
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