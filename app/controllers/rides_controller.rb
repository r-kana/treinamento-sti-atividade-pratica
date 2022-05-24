class RidesController < ApplicationController
  before_action :set_ride, only: %i[ show edit update destroy book toggle_active ]
  before_action :set_user, only: [:index, :show, :new, :edit, :create, :destroy, :toggle_active]

  def search
    @rides = Ride.search(params).where.not(driver: @logged_user).order(date: :desc)
  end

  def book
    if @ride.book_seat
      redirect_to ride_url(@ride), notice: "Ride was successfully booked."
    else
      render :search, status: :unprocessable_entity
    end
  end

  def index
    Ride.deactivate_past_rides(@logged_user)
    @rides = Ride.all.where(driver: @logged_user).order(date: :desc)
  end

  def show
  end

  def new
    @ride = Ride.new
  end

  def edit
  end

  def create
    @ride = Ride.new(ride_params)
    @ride.driver_id = @logged_user.id
    if @ride.to_college
      @ride.destination_neighborhood = @ride.college.neighborhood
    else
      @ride.departure_neighborhood = @ride.college.neighborhood
    end
    if @ride.save
      @departure = @ride.create_departure(departure_ride_params)
      @destination = @ride.create_destination(destination_ride_params)
      if @departure.errors.any? or @destination.errors.any?
        @ride.destroy
        @departure.destroy if @departure.errors.any?
        @destination.destroy if @destination.errors.any?
        render :new, status: :unprocessable_entity 
      else  
        redirect_to new_ride_waypoints_url(@ride), notice: "Carona criada com sucesso." 
      end
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def update
    if @ride.update(ride_params)
      @destination = @ride.update_destination(destination_ride_params)
      @departure = @ride.update_departure(departure_ride_params)
      if @departure.errors.any? or @destination.errors.any?
        render :edit, status: :unprocessable_entity
      else
        redirect_to new_ride_waypoints_url(@ride), notice: "Corrida atualizada com sucesso."
      end
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    @ride.destroy
    redirect_to user_rides_url(@logged_user), notice: "Corrida apagada com sucesso."
  end

  def toggle_active
    if @ride.update(active: not(@ride.active?))
      redirect_to user_rides_url(@logged_user), notice: "Corrida #{@ride.active? ? "reativada" : "desativada"} com sucesso." 
    else
      render :index
    end
  end
  

  private
    def set_ride
      @ride = Ride.find(params[:id])
    end

    def set_user 
      @logged_user = User.find(params[:user_id])
    end

    def ride_params
      params.require(:ride).permit(
        :price, 
        :seats, 
        :observation, 
        :college_id, 
        :time, 
        :date, 
        :to_college, 
        :destination_neighborhood,
        :departure_neighborhood
      )
    end

    def destination_ride_params
      params.require(:ride).permit( 
        :destination_neighborhood, 
        :destination_address,
        :destination_city
      )
    end

    def departure_ride_params
      params.require(:ride).permit(
        :departure_neighborhood,
        :departure_address,
        :departure_city
      )
    end
end
