class Waypoint < ApplicationRecord
  belongs_to :ride, dependent: :destroy

  enum kind: [ :departure, :destination, :stop ]

  def self.create_stops params
    

end
