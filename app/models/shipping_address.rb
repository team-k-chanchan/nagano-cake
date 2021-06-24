class ShippingAddress < ApplicationRecord

  def order_address
    '〒' + self.postal_code + '' + self.shipping_address + '' + self.name
  end
end
