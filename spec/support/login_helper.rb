module LoginHelper
  include Iduff::KeycloakClient::Support::LoginHelper

  def login_user(user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    login(user.iduff)
    visit('/')
  end

  private
  RSpec.configure do |config|
    config.include LoginHelper
  end
end


