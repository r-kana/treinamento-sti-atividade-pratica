class Ride < ApplicationRecord
  has_many :waypoints
  belongs_to :driver, class_name: :User
  has_many :users, through: :reservation

  validates :time, :date, :seats, :price, :college_id, :driver_id, presence: true, on: :create
  validates :seats, numericality: { greater_than: 0, only_integer: true } 
  validates :to_college, :active, :full, inclusion: { in: [false, true] }

  validate :passagers_cannot_be_greater_than_seats, on: :update
  validate :cannot_be_in_past


  def self.availables
    Ride.all.where(
      'active = :active AND rides.full = :full AND (date > :date OR (date = :date AND time >= :time))', 
      active: true, full: false, date: Date.today, time: Time.now
    ).order(:date)
  end

  def self.search (query)
    if query[:destination].nil? and query[:departure].nil?
      Ride.availables
    else
      Ride.availables.where('destination_neighborhood LIKE ? OR departure_neighborhood LIKE ?',  
                             "#{query[:destination]}%", "#{query[:departure]}%")
    end
  end
  
  def book_seat
    self.number_of_passagers += 1
    return update(full: (self.seats == self.number_of_passagers), number_of_passagers: self.number_of_passagers)
  end

  def departure
    self.waypoints.where(kind: :departure).first
  end

  def destination
    self.waypoints.where(kind: :destination).first
  end

  def stops
    self.waypoints.where(type: :stop).order(:order)
  end

  def create_destination(params)
    destination = Waypoint.new(
      address: params[:address],
      city: params[:city],
      meighborhood: params[:neighborhood],
      order: 0,
      is_college: self.to_college,
      kind: :destination,
      ride_id: self.id
    )
    destination.save
    return destination
  end

  def create_departure(params)
    departure = Waypoint.create(
      address: params[:address],
      city: params[:city],
      meighborhood: params[:neighborhood],
      order: 0,
      is_college: not(self.to_college),
      kind: :departure,
      ride_id: self.id
    )
    departure.save
    return departure
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
end
