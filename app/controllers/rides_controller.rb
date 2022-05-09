class RidesController < ApplicationController
  before_action :set_ride, only: %i[ show edit update destroy book toggle_activate ]

  def search
    @rides = Ride.search(params).order(:date)
  end

  def book
    if @ride.book_seat
      redirect_to ride_url(@ride), notice: "Ride was successfully booked."
    else
      render :search, status: :unprocessable_entity
    end
  end

  def index
    @rides = Ride.availables.where(driver: @current_user).order(:date)
  end

  def show
    @waypoints = @ride.waypoints
  end

  def new
    @ride = Ride.new
  end

  def edit
  end

  def create
    @ride = Ride.new(create_ride_params)
    @ride.driver_id = @current_user.id
    if @ride.save
      departure = @ride.create_departure(departure_ride_params)
      destination = @ride.create_destination(destination_ride_params)
      if departure.errors.any? or destination.errors.any?
        render :new, status: :unprocessable_entity 
      else  
        redirect_to user_ride_url(@current_user, @ride), notice: "Carona criada com sucesso." 
      end
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def update
    ride_params[driver_id: @current_user.id]
    if @ride.update(ride_params)
      redirect_to user_ride_url(@current_user, @ride), notice: "Ride was successfully updated."
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    @ride.destroy
    redirect_to user_rides_url(@current_user), notice: "Ride was successfully destroyed."
  end

  def toggle_activate
    if @ride.update(active: not(@ride.active?))
      redirect_to user_rides_url(@current_user), notice: "Corrida #{@ride.active? ? "reativada" : "desativada"} com sucesso." 
    else
      render :index
    end
  end
  

  private
    def set_ride
      @ride = Ride.find(params[:id])
    end

    def create_ride_params
      params.require(:ride).permit(
        :price, 
        :seats, 
        :observation, 
        :college_id, 
        :time, 
        :date, 
        :to_college, 
        :destination_neighborhood
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
