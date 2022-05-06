class RidesController < ApplicationController
  before_action :set_driver
  before_action :set_ride, only: %i[ show edit update destroy book ]

   # GET /search?departure=''&destination=''&to_college=''
  def search
    @rides = Rides.search(params)
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
    @rides = Ride.availables.where(driver: @drive)
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
    @ride.driver_id = @driver.id
    respond_to do |format|
      if @ride.save
        format.html { redirect_to user_ride_url(@driver, @ride), notice: "Ride was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      ride_params[driver_id: @driver.id]
      if @ride.update(ride_params)
        format.html { redirect_to user_ride_url(@driver, @ride), notice: "Ride was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ride.destroy
    respond_to do |format|
      format.html { redirect_to user_rides_url(@driver), notice: "Ride was successfully destroyed." }
    end
  end

  private
    def set_ride
      @ride = Ride.find(params[:id])
    end

    def set_driver
      @driver = User.find(params[:user_id])
    end

    def ride_params
      params.require(:ride).permit(:prince, :seats, :observation, :college_id, :time, :date, :to_college)
    end
end
