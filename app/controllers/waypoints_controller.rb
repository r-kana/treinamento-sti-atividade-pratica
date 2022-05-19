  class WaypointsController < ApplicationController
  before_action :set_waypoint, only: %i[ update destroy ]
  before_action :set_ride, except: :destroy


  def new
  end

  def edit
  end

  def create
    if Waypoint.create_list params.permit!
      redirect_to user_ride_path(@logged_user, @ride)
    else
      render :new, notice: "Um erro ocorreu ao tentar salvar as paradas", status: :unprocessable_entity
    end
  end

  def destroy
    @waypoint.destroy
    render json:{ head: :no_content }
  end

  private
    def set_waypoint
      @waypoint = Waypoint.find(params[:id])
    end

    def set_ride
      @ride = Ride.find(params[:ride_id])
    end

end
