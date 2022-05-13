class WelcomeController < ApplicationController
  skip_before_action :user_from_cookie, only: :index
  
  def index
  end

  def home
  end

end