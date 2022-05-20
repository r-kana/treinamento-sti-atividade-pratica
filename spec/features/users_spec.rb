require 'rails_helper'

RSpec.feature 'Usuários', type: :feature, js: true do

  let!(:user){ create(:user, cpf: '00000000001', name: "Usuário Teste") }
  let!(:admin){ create(:user, :is_admin, cpf: '00000000000', name: "Adm") }

  describe 'Cadastro de Usuário' do
    before(:each) do 
      login_user(create(:user, :is_admin))
      visit(new_user_path)
    end

    context 'com parametros válidos' do
      it 'deve cadastrar um novo usuário' do
        fill_in('user_name', with: Faker::Name.first_name)
        fill_in('user_cpf', with: "#{Faker::Number.number(digits: 11)}")
        click_on('Salvar')
        expect(find('#notice')).to have_text("Usuário criado com sucesso")
        expect(page).to have_current_path(users_path)
      end
    end
    context 'com parâmetros inválidos' do
      before(:each) do
        fill_in('user_name', with: Faker::Name.first_name)
        fill_in('user_cpf', with: "#{Faker::Number.number(digits: 10)}")
        click_on('Salvar')
      end

      it 'deve retornar erros' do
        expect(find('#error_explanation > ul')).to have_text("Cpf é inválido")
      end

      it 'não deve criar um usuário' do
        expect(find('#error_explanation > h2')).to have_text("Alguns erros proibiram esse usuário de ser salvo:")
        expect(page).to have_current_path(users_path)
      end
    end

    context 'com parâmetros faltando' do
      before(:each) do
        fill_in('user_name', with: nil)
        fill_in('user_cpf', with: nil)
        click_on('Salvar')
      end

      it 'deve retornar erros' do
        expect(find('#error_explanation > ul')).to have_text("Cpf não pode ficar vazio")
        expect(find('#error_explanation > ul')).to have_text("Name não pode ficar vazio")
      end

      it 'não deve criar um usuário' do
        expect(find('#error_explanation > h2')).to have_text("Alguns erros proibiram esse usuário de ser salvo:")
        expect(page).to have_current_path(users_path)
      end
    end

  end
  describe 'Edição' do
    before(:each) do
      login_user(admin)
      visit(edit_user_path(user))
    end

    it 'deve ter inputs preenchidos' do
      expect(find('#user_name').value).to eq('Usuário Teste')
      expect(find('#user_cpf').value).to eq('00000000001')
    end

    context 'com parâmetros válidos' do 
      it 'deve editar com sucesso' do
        fill_in('user_name', with: Faker::Name.first_name)
        fill_in('user_cpf', with: "#{Faker::Number.number(digits: 11)}")
        click_on('Salvar')
        expect(find('#notice')).to have_text('Usuário atualizado com sucesso.')
        expect(page).to have_current_path(users_path)
      end
    end
    context 'com parâmetros inválidos' do
      before(:each) do
        fill_in('user_name', with: Faker::Name.first_name)
        fill_in('user_cpf', with: "#{Faker::Number.number(digits: 10)}")
        click_on('Salvar')
      end

      it 'deve retornar errors' do
        expect(find('#error_explanation')).to have_text("Cpf é inválido")
      end

      it 'não deve atualizar o usuário' do
        expect(find('#error_explanation')).to have_text('Alguns erros proibiram esse usuário de ser salvo:')
        expect(page).to have_current_path(user_path(user))
      end
    end

    context 'com parâmetros faltando' do
      before(:each) do
        fill_in('user_name', with: nil)
        fill_in('user_cpf', with: nil)
        click_on('Salvar')
      end
      
      it 'deve retornar erros' do
        expect(find('#error_explanation')).to have_text("Cpf não pode ficar vazio")
        expect(find('#error_explanation')).to have_text("Name não pode ficar vazio")
      end

      it 'não deve atualizar o usuário' do
        expect(find('#error_explanation')).to have_text("Alguns erros proibiram esse usuário de ser salvo:")
        expect(page).to have_current_path(user_path(user))
      end
    end

    context 'tornar usuário desativado' do
      it 'deve mostrar que está desativo' do
        visit(users_path)
        accept_alert do
          find("a", id: "toggle-active-#{user.id}").click
        end
        expect(find("#card-#{user.id}")).to have_text('Desativado')
      end
    end
  end

end