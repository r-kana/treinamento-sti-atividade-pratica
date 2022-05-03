class AuthenticateController < ApplicationController
  def login
    @user = User.find_by(iduff: params[:iduff])
    @user = @user&authenticate(params[:password])
    respond_to do |format|
      if @user
        format.html { redirect_to  @user }
      else  
        format.html { redirect_to home_path }
      end
    end
  end


end
