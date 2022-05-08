class WelcomeController < ApplicationController
  skip_before_action :user_from_cookie
  
  def index
  end

  def home
  end

end