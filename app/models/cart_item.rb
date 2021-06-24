class CartItem < ApplicationRecord
   
   belongs_to :item
   belongs_to :customer
   
   validates :customer_id, :item_id, :quantity, presence: true
   
end
