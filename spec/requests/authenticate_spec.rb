require 'rails_helper'

RSpec.describe "Authenticates", type: :request do

  describe "GET /login" do
    it "returns http success" do
      user = create(:user, password: '123')
      post "/login", params: { iduff: user.iduff, password: '123' }
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(home_path)
    end
  end

end
