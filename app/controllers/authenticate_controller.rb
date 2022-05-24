class AuthenticateController < ApplicationController
  def logout
    redirect_to welcome_url
  end
end
