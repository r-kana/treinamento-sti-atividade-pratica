class Waypoint < ApplicationRecord
  belongs_to :ride, dependent: :destroy

  enum kind: [ :departure, :destination, :stop ]

  def self.create_stops params
    saved_waypoints = []
    waypoints = params.require(:waypoint)
    waypoints.each_key do |k|
      waypoint = Waypoint.new(waypoints[k])
      waypoint.is_college = false
      waypoint.ride_id = params[:ride_id]
      waypoint.kind = :stop
      if waypoint.save
        saved_waypoints << waypoint
      else
        saved_waypoints.each {|w| w.destroy} 
        return false
      end
    end
    return true
  end
end
