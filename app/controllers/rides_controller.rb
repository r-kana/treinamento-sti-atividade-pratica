class RidesController < ApplicationController
  before_action :user_from_cookie
  before_action :set_ride, only: %i[ show edit update destroy book ]

  def search
    @rides = Ride.search(params).order(:date)
  end

  def book
    respond_to do |format|
      if @ride.book_seat
        format.html { redirect_to ride_url(@ride), notice: "Ride was successfully booked." }
      else
        format.html { render :search, status: :unprocessable_entity }
      end
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
    @ride = Ride.new(ride_params)
    @ride.driver_id = @current_user.id
    @ride.destination_neighborhood = params[:destination]
    @ride.desparture_neighborhood = params[:departure]
    respond_to do |format|
      if @ride.save


        format.html { redirect_to user_ride_url(@current_user, @ride), notice: "Ride was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      ride_params[driver_id: @current_user.id]
      if @ride.update(ride_params)
        format.html { redirect_to user_ride_url(@current_user, @ride), notice: "Ride was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ride.destroy
    respond_to do |format|
      format.html { redirect_to user_rides_url(@current_user), notice: "Ride was successfully destroyed." }
    end
  end

  private
    def set_ride
      @ride = Ride.find(params[:id])
    end

    def ride_params
      params.require(:ride).permit(:price, :seats, :observation, :college_id, :time, :date, :to_college, :destination, :departure)
    end
end
