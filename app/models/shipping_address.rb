class ShippingAddress < ApplicationRecord
  belongs_to :customer

	validates :customer_id, :name, :shipping_address, presence: true
	validates :postal_code, length: {is: 7}, numericality: { only_integer: true }

	def order_address
			self.postal_code + self.shipping_address + self.name
	end
end
