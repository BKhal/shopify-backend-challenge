class Product < ApplicationRecord
  # Product name must be present and unique
  validates :name, presence: true, uniqueness: true
  # Product quantity must be present and a non-negative integer
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  def self.to_csv
    attributes = %w{name quantity}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |product|
        csv << attributes.map{ |attr| product.send(attr) }
      end
    end
  end
end
