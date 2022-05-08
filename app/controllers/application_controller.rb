class ApplicationController < ActionController::Base
  before_action :user_from_cookie

  def user_from_cookie
    p 'COOKIE'
    if cookies.signed[:user_id]
      @current_user = User.find(cookies.signed[:user_id])
    else
      redirect_to welcome_url, notice: "Usuário sem acesso. Login necessário" 
    end
  end
end
