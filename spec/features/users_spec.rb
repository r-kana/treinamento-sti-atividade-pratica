require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  describe 'Cadastro de Usuário' do
    context 'com parametros corretos' do
      it 'deve cadastrar um novo usuário' do
        visit(new_user_path)
        fill_in('name', with: Faker::Name.first_name)
        fill_in('cpf', with: "#{Faker::Number.number(digits: 11)}")
        click_on('Salvar')
        expect(page).to have_content("Usuário criado com sucesso")
        expect(page).to have_current_path(users_path)
      end
    end

  end
  describe 'Edição de Usuário' do
    
  end

end