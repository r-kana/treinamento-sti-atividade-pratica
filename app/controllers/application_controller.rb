class ApplicationController < ActionController::Base
  def user_from_cookie
    @current_user = User.find(cookies.signed[:user_id])
  end
end
