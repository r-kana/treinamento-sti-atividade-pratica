class College < ApplicationRecord
  validates :name, :address, :neighborhood, :city, :phone_number, :cep, :active, presence: true
  validates :active, inclusion: {in: [true, false]}
  validates :phone_number, lenght: {in: 12}, format: { with: /\d{2}\s\d{4}\-\d{4}/s}
  validates :cep, length: {is: 11}, format: {with: /\d{5}\-\d{3}/s}
end
