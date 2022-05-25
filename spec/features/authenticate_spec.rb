require 'rails_helper'

RSpec.feature 'Autenticação', type: :feature do

  describe 'login' do
    context  'com crêdenciais válidas' do
      it 'deve realizar o login com sucesso' do
        create(:user)
        login_user(create(:user))
        visit('/')
        page.save_screenshot('login.png')
        expect(page).to have_content('HOME')
      end
    end
  end

end