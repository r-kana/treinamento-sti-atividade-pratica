class Ride < ApplicationRecord
  has_many :waypoints
  belongs_to :driver, class_name: :User

  def self.availables
    Ride.all.where('active = ? and rides.full = ? and date <= ?', true, false, Date.today).order(:date)
  end

  def self.search (query)
    if query[:destination].nil? and query[:departure].nil?
      Ride.availables
    else
      Ride.availables.where('destination_neighborhood = ? or departure_neighborhood = ?',  
                             query[:destination], query[:departure])
    end
  end
  
  def book_seat
    self.number_of_passagers += 1
    return self.update(full: (self.seats == self.number_of_passagers), 
                       number_of_passagers: self.number_of_passagers)
  end

  def departure
    self.waypoints.where(type: :departure)
  end

  def destination
    self.waypoints.where(type: :destination)
  end

  def stops
    self.waypoints.where(type: :stop)
  end

end
