class Product < ApplicationRecord
  # Product name must be present and unique
  validates :name, presence: true, uniqueness: true
  # Product quantity must be present and a non-negative integer
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true, less_than: 2**31 }

  # In an actual production level application, this has the potential to cause massive slowdowns for all
  # concurrent users whenever a request is made for CSV data. This can be avoided through using a background job.
  # However, since this application will likely only ever have one active user (the Shopify reviewer) I have decided to
  # leave this process inline.
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
