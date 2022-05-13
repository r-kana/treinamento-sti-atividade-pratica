require 'rails_helper'

RSpec.describe 'Colleges', type: :request do
  let!(:college) { build(:college) }

  let(:valid_params) {{
    name: "Teste", 
    address: 'Rua teste', 
    neighborhood: 'Bairro teste',
    city: 'Cidade teste',
    cep: '20000-000',
    phone_number: '000000-0000' 
  }}

  let(:invalid_params) {{
    name: "Teste", 
    address: 'Rua teste', 
    neighborhood: 'Bairro teste',
    city: 'Cidade teste',
    cep: nil,
    phone_number: '000000' 
  }}

  let!(:admin) { create(:user, :is_admin, password: '123')}

  def login user
    post "/login", params: { cpf: user.cpf, password: '123' }
  end 
  before(:each) { login admin }

  describe 'Registo de novo campus' do
    context 'com parametros corretos' do
      it 'retornar resposta com status found' do
        post colleges_path, params: {college: valid_params}
        expect(response).to have_http_status(:found)
      end
      
      it 'cria um novo registro no banco de dados' do 
        expect {
          post colleges_path, params: {college: valid_params}
        }.to change(College, :count).by(1)
        expect(College.last.name).to eq('Teste')
      end

      it 'redireciona de volta para a lista de campus' do
        post colleges_url, params: {college: valid_params}
        expect(response.content_type).to start_with('text/html')
        expect(response).to redirect_to(colleges_url)
        follow_redirect!
        expect(response).to render_template(:index)
        expect(response.body).to include("Campus criado com sucesso.")
      end
    end

    context 'com parametros incorretos' do
      it 'retornar resposta com status unprocessable entity' do
        post colleges_url, params: {college: invalid_params}
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'redirecionar para o formulário de cadastro' do
        post colleges_url, params: {college: invalid_params}
        expect(response).to render_template(:new)
        expect(response.content_type).to start_with('text/html')
      end
    end
  end
end
