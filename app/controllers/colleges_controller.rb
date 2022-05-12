class CollegesController < ApplicationController
  before_action :set_college, only: [:edit, :update, :toggle_active]
  
  def index
    @colleges = College.all.order(:name)
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @colleges }
    end
  end

  def new
    @college = College.new
  end

  def edit
  end

  def create 
    @college = College.new(college_params)
    @college.active ||= true
    respond_to do |format|
      if @college.save
        format.html { redirect_to colleges_url, notice: 'Campus criado com sucesso.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @college.update(college_params)
      redirect_to colleges_url
    else
      render :edit
    end
  end

  def toggle_active
    if @college.update(active: not(@college.active?))
      redirect_to colleges_url, notice: "Campus #{@college.active? ? "reativado" : "desativado"} excluído com sucesso."
    else
      render :index, status: :unprocessable_entity
    end
  end

  private
  def set_college
    @college = College.find params[:id]
  end

  def college_params
    params.require(:college).permit(:name, :address, :neighborhood, :city, :phone_number, :cep, :active)
  end
end