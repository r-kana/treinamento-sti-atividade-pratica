class User < ApplicationRecord
  has_secure_password
  validates :name, :cpf, :active, presence: true, on: :create
  validates :cpf, format: { with: /\d{11}/s }, uniqueness: true
  validates :active, :admin, inclusion: { in: [true, false] }, on: :update

  has_many :rides, through: :reservation

  def rides
    Ride.where(driver_id: self.id)
  end

  def active?
    self.active
  end

  def admin?
    self.admin
  end

  def self.search_query(query)
    if query.nil?
      User.all.order(:name)
    else
      User.where("name LIKE :q OR cpf LIKE :q OR iduff LIKE :q", q: "#{query}%").order(:name).limit(20)
    end
  end
  
end
