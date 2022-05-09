class CollegesController < ApplicationController
  before_action :user_from_cookie
  before_action :set_college, only: [:update, :toggle_activate]
  
  def index
    @colleges = College.all.order(:name)
  end

  def new
    @college = College.new
  end

  def edit
  end

  def create 
    @college = College.new(college_params)
    @college.active ||= true
    if @college.save
      redirect_to colleges_url, notice: 'Campus criado com sucesso.' 
    else
      render :new 
    end
  end

  def update
    if @college.update(colleg_params)
      redirect_to college_url(@college)
    else
      render :edit
    end
  end

  def toggle_activate
    if @college.update(active: not(@college.active?))
      redirect_to colleges_url, notice: "Campus #{@college.active? ? "reativado" : "desativado"} excluído com sucesso."
    else
      render :index, status: :unprocessable_entity 
    end
  end

  private
  def set_college
    College.find params[:id]
  end

  def college_params
    params.require(:college).permit(:name, :address, :neighborhood, :city, :phone_number, :cep, :active)
  end
end