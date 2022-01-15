class Product < ApplicationRecord
  # Product name must be present and unique
  validates :name, presence: true, uniqueness: true
  # Product quantity must be present and a non-negative integer
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
end
