class WaypointsController < ApplicationController
  before_action :set_waypoint, only: %i[ update destroy ]

  def create
    @waypoint = Waypoint.new(waypoint_params)

    respond_to do |format|
      if @waypoint.save
        format.html { redirect_to waypoint_url(@waypoint), notice: "Waypoint was successfully created." }
        format.json { render :show, status: :created, location: @waypoint }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @waypoint.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # TODO Retorno em json
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
    # TODO Retorno em json
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

    # Only allow a list of trusted parameters through.
    def waypoint_params
      params.require(:waypoint).permit(:order, :type, :is_college, :address, :neighborhood, :city)
    end
end
