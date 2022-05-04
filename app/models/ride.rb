class Ride < ApplicationRecord
  belongs_to :departure, class_name: :Waypoint
  belongs_to :destination, class_name: :Waypoint
  has_many :waypoints
  belongs_to :user

  def self.availables
    Rides.all.where('active = ? and full = ? and date >= ?', true, false, Date.today).order(:date)
  end

  def self.search (query)
    # TODO Implementar busca via query params
    Rides.availables.joins(:destination, :departure)
                    .where('destination.neighborhood = ? or departure.neighborhood = ?',  
                            query[:destination], query[:departure]))
  end
  def book_seat
    self.number_of_passagers += 1
    self.full = true if self.seats == self.number_of_passagers
    return self.update(full: self.full, number_of_passagers: self.number_of_passagers)
end
