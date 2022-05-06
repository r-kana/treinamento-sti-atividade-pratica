class User < ApplicationRecord
  has_secure_password
  validates :name, :iduff, :cpf, :active, presence: true
  validates :iduff, format: {with: /[\w\.\-]+@id\.uff\.br/s}, uniqueness: true
  validates :cpf, format: {with: /\d{3}\.\d{3}\.\d{3}\-\d{2}/s}, uniqueness: true

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
  
end
