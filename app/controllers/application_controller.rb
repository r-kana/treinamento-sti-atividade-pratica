class ApplicationController < ActionController::Base
  # authenticate_with_iduff_keycloak
  before_action :logged_user
  def logged_user
    auth = Iduff::KeycloakClient::Authenticator.new(nil, nil, nil)
    @logged_user = User.find_by(cpf: auth.hash_iduff[:iduff])
    # @logged_user = User.find_by(cpf: current_user.cpf)
  end
end