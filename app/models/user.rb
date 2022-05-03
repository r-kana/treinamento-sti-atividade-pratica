class User < ApplicationRecord
  validates :name, :iduff, :cpf, presence: true
  validates :iduff, format: {with: /[\w\.\-]+@id\.uff\.br/s}, uniqueness: true
  validates :cpf, format: {with: /\d{3}\.\d{3}\.\d{3}\-\d{2}/s}
end
