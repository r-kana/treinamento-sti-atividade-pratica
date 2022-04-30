class CollegesController < ApplicationController
  before_action :set_action, only: [:show, :update, :destroy]
  
  def index
    @colleges = College.all
  end

  def show
  end

  def create 
    @college = College.new(college_params)
    @college.active ||= true
    if @college.save

  end
  
  private
  def set_college
    College.find params[:id]
  end
  def college_params
    params.require(:college).permit(:name, :address, :neighborhood, :city, :phone_number, :cep, :active)
  end
end