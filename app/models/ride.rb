class Ride < ApplicationRecord
  has_many :waypoints
  belongs_to :driver, class_name: :User
  has_many :users, through: :reservation

  validates :time, :date, :price, :college_id, :driver_id, presence: true
  validates :seats, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :to_college, :active, :full, inclusion: { in: [false, true] }

  validate :passagers_cannot_be_greater_than_seats, on: :update
  validate :cannot_be_in_past, on: [:create, :update]


  def self.availables
    Ride.all.where('active = ? and rides.full = ? and date >= ?', true, false, Date.today).order(:date)
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
    return update(full: (self.seats == self.number_of_passagers), number_of_passagers: self.number_of_passagers)
  end

  def departure
    self.fwaypoints.where(kind: :departure).first
  end

  def destination
    self.waypoints.where(kind: :destination).first
  end

  def stops
    self.waypoints.where(type: :stop)
  end

  private 

  def passagers_cannot_be_greater_than_seats
    if self.seats < self.number_of_passagers
      errors.add(:number_of_passagers, "can't be greater than seats")
    end
  end

  def cannot_be_in_past
    if self.time and self.date
      if self.date < Date.today 
        errors.add(:date, 'cannot be in the past')
      end
      if self.date == Date.today and self.time < Time.now
        errors.add(:time, 'cannot be in the past')
      end
    end
  end


  private 

end
