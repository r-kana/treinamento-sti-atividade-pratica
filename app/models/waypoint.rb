class Waypoint < ApplicationRecord
  belongs_to :ride, dependent: :destroy

  enum kind: [ :departure, :destination, :stop ]
end
