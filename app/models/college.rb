class College < ApplicationRecord
  validates :name, :address, :neighborhood, :city, :phone_number, :cep, :active, presence: true, on: :create
  validates :active, inclusion: [true, false], on: :update
  validates :phone_number, length: {is: 11}, format: { with: /\d{2}\d{4}\-\d{4}/s}
  validates :cep, length: {is: 9}, format: {with: /\d{5}\-\d{3}/s}

  def active?
    self.active
  end

end
