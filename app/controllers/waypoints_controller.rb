  class WaypointsController < ApplicationController
  before_action :set_waypoint, only: %i[ update destroy ]
  before_action :set_ride, only: [:add_stops, :create_stops]


  def add_stops
  end

  def create_stops
    if Waypoint.create_stops params.permit!
      redirect_to user_ride_path(@current_user, @ride)
    else
      render :add_stops, notice: "Um erro ocorreu ao tentar salvar as paradas", status: :unprocessable_entity
    end
  end


  def update
    respond_to do |format|
      if @waypoint.update(waypoint_params)
        format.html { redirect_to waypoint_url(@waypoint), notice: "Waypoint was successfully updated." } 
        format.json { render :show, status: :ok, location: @waypoint }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @waypoint.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @waypoint.destroy

    respond_to do |format|
      format.html { redirect_to waypoints_url, notice: "Waypoint was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_waypoint
      @waypoint = Waypoint.find(params[:id])
    end

    def set_ride
      @ride = Ride.find(params[:ride_id])
    end

end
