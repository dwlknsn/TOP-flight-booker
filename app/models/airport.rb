class Airport < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :city, presence: true
  validates :country, presence: true
  validates :region, presence: true
end
