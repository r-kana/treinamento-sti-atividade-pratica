class UsersController < ApplicationController
  before_action :user_from_cookie
  before_action :set_user, only: %i[ show edit update destroy rides ]

  def index
    @users = User.all
  end
  # User as a driver
  def rides
    @rides = @current_user.rides
  end
  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_create_params)
    @user.password = user_create_params[:cpf]
    @user.active = true
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: "User was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_update_params)
        format.html { redirect_to users_url, notice: "User was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_update_params
      params.require(:user).permit(:name, :iduff, :cpf, :password, :active, :admin)
    end

    def user_create_params
      params.require(:user).permit(:name, :iduff, :cpf, :admin)
    end
end
