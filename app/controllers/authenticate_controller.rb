class AuthenticateController < ApplicationController
  skip_before_action :user_from_cookie, only: [:login]

  def login
    @current_user = User.find_by(iduff: params[:iduff])
    if @current_user&.authenticate(params[:password])
      cookies.signed[:user_id] = @current_user.id
      render 'welcome/home' 
    else  
      redirect_to home_url, notice: 'Email ou senha incorretos'
    end
  end

  def logout
    cookies.delete :user_id
    redirect_to welcome_url
  end



end
