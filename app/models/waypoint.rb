class Waypoint < ApplicationRecord
  belongs_to :ride

  validates :kind, :ride_id, :address, :neighborhood, :city, :order, presence: true

  enum kind: [ :departure, :destination, :stop ]

  def self.create_list params
    saved_waypoints = []
    if params[:new_waypoint]
      waypoints = params.require(:new_waypoint)
      waypoints.each_key do |k|
        waypoint = Waypoint.new(waypoints[k])
        waypoint.ride_id = params[:ride_id]
        if waypoint.save
          saved_waypoints << waypoint
        else
          saved_waypoints.each {|w| w.destroy} 
          return false
        end
      end
    end
    return true
  end
end
