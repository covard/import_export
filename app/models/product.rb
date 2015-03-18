class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true,
            numericality: true,
            format: { with: /\A\d{1,4}(\.\d{0,2})?\z/ }

  def self.find_by_sku(sku)
    self.where(sku: sku).first
  end
end
