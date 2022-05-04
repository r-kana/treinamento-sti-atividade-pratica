class Ride < ApplicationRecord
  belongs_to :departure, class_name: :Waypoint
  belongs_to :destination, class_name: :Waypoint
  has_many :waypoints
  belongs_to :user

end
