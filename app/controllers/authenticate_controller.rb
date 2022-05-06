class AuthenticateController < ApplicationController
  def login
    @user = User.find_by(iduff: params[:iduff])
    @user = @user&.authenticate(params[:password])
    respond_to do |format|
      if @user
        cookies.signed[:user_id] = @user.id
        format.html { redirect_to  home_url }
      else  
        format.html { redirect_to home_path, notice: 'Email ou senha incorretos'}
      end
    end
  end


end
