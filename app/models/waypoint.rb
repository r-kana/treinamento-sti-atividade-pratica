class Waypoint < ApplicationRecord
  belongs_to :ride, dependent: :destroy

  enum type: [ :departure, :destination, :stop ]
end
