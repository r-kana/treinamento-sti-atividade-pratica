class Ride < ApplicationRecord
  has_many :waypoints, dependent: :destroy
  belongs_to :driver, class_name: :User
  has_many :users, through: :reservation

  validates :time, :date, :seats, :price, :college_id, :driver_id, presence: true, on: :create
  validates :seats, numericality: { greater_than: 0, only_integer: true } 
  validates :to_college, :active, :full, inclusion: { in: [false, true] }

  validate :passagers_cannot_be_greater_than_seats, on: :update
  validate :cannot_be_in_past


  def self.deactivate_past_rides user
    rides = Ride.where(driver_id: user.id)
    rides.each do |ride| 
      if ride.date < Date.today or (ride.date == Date.today and ride.time < Time.now)
        ride.update(active: false) 
      end
    end
  end

  def self.availables
    Ride.all.where(
      'active = :active AND rides.full = :full AND (date > :date OR (date = :date AND time > :time))', 
      active: true, full: false, date: Date.today, time: Time.now
    ).order(:date)
  end

  def self.search (query)
    if query[:departure_kind].nil? and query[:destination_kind].nil?
      Ride.availables
    else
      if query[:ride][:neighborhood].present?
        if query[:destination_kind] == 'college'
          query[:destination] = query[:ride][:neighborhood]

        elsif query[:departure_kind] == 'college'
          query[:departure] = query[:ride][:neighborhood]
        end
      end
      Ride.availables.where('destination_neighborhood LIKE ? AND departure_neighborhood LIKE ?',  
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

  def college
    College.find(self.college_id)
  end

  def active?
    self.active
  end

  def create_destination(params)
    if self.to_college
      college = self.college
      params[:destination_address] = college.address
      params[:destination_neighborhood] = college.neighborhood
      params[:destination_city] = college.city
    end
    destination = Waypoint.new(
      address: params[:destination_address],
      city: params[:destination_city],
      neighborhood: params[:destination_neighborhood],
      order: 0,
      is_college: self.to_college,
      kind: :destination,
      ride_id: self.id
    )
    destination.save
    return destination
  end

  def create_departure(params)
    unless self.to_college
      college = self.college
      params[:departure_address] = college.address
      params[:departure_neighborhood] = college.neighborhood
      params[:departure_city] = college.city
    end
    departure = Waypoint.new(
      address: params[:departure_address],
      city: params[:departure_city],
      neighborhood: params[:departure_neighborhood],
      order: 0,
      is_college: not(self.to_college),
      kind: :departure,
      ride_id: self.id
    )
    departure.save
    return departure
  end

  def update_destination params
    if self.to_college
      college = self.college
      params[:destination_address] = college.address
      params[:destination_neighborhood] = college.neighborhood
      params[:destination_city] = college.city
    end
    destination = self.destination
    destination.update(
      address: params[:destination_address],
      city: params[:destination_city],
      neighborhood: params[:destination_neighborhood],
      is_college: self.to_college
    )
    return destination
  end

  def update_departure params
    unless self.to_college
      college = self.college
      params[:departure_address] = college.address
      params[:departure_neighborhood] = college.neighborhood
      params[:departure_city] = college.city
    end
    departure = self.departure
    departure.update(
      address: params[:departure_address],
      city: params[:departure_city],
      neighborhood: params[:departure_neighborhood],
      is_college: not(self.to_college)
    )
    return departure
  end

  def ordered_waypoints
    self.waypoints.order(:order)
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
