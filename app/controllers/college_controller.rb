class CollegeController < ApplicationController
  before_action :set_action, only: [:show, :update, :destroy]
  
  def index
    @colleges = College.all
  end

  def show
  end

  def create 
    @college = College.new(college_params)
    @college.active ||= true
    respond_to do |format|
      if @college.save
        format.html { redirect_to @college, notice: 'Campus criado com sucesso.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @college.update(colleg_params)
        format.html {redirect_to: @college}
      else
        format.html {redirect_to: :edit}
      end
    end
  end

  def destroy
    @college.destroy
    respond_to do |format|
      format.html { redirect_to colleges_url, notice: 'Campus excluído com sucesso.' }
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
