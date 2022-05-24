class ApplicationController < ActionController::Base
  authenticate_with_iduff_keycloak
  before_action :logged_user
  
  def logged_user
    @logged_user = User.find_by(iduff: current_user.iduff)
  end
end