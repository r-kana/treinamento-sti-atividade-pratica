class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update toggle_active rides ]

  def index
    @users = User.search_query(params[:q])
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @users }
    end
  end

  def rides
    @rides = @logged_user.rides
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
    @user.active = true
    if @user.save
      redirect_to users_url, notice: "Usuário criado com sucesso."
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def update
    if @user.update(user_update_params)
      redirect_to users_url, notice: "Usuário atualizado com sucesso." 
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  def toggle_active
    @users = User.search_query(nil)
    if @user.update!(active: not(@user.active?))
      redirect_to users_url, notice: "Usuário #{@user.active? ? "reativado" : "desativado"} com sucesso." 
    else 
      render :index, status: :unprocessable_entity 
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_update_params
      params.require(:user).permit(:name, :iduff, :active, :admin)
    end

    def user_create_params
      params.require(:user).permit(:name, :iduff, :admin)
    end
end
