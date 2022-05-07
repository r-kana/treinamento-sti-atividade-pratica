class AuthenticateController < ApplicationController
  before_action :user_from_cookie
  def login
    @current_user = User.find_by(iduff: params[:iduff])
    @current_user = @user&.authenticate(params[:password])
    respond_to do |format|
      if @current_user
        cookies.signed[:user_id] = @current_user.id
        format.html { redirect_to  home_url }
      else  
        format.html { redirect_to home_path, notice: 'Email ou senha incorretos'}
      end
    end
  end

  def logout
    cookies.delete :user_id
    respond_to do |format|
      format.html {redirect_to welcome_path}
    end
  end



end
