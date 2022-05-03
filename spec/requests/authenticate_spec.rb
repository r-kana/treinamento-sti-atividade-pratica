require 'rails_helper'

RSpec.describe "Authenticates", type: :request do
  describe "GET /login" do
    it "returns http success" do
      get "/authenticate/login"
      expect(response).to have_http_status(:success)
    end
  end

end
