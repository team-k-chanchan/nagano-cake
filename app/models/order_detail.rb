class OrderDetail < ApplicationRecord

    belongs_to :order
	belongs_to :item

	validates :item_id, :order_id, :quantity,
			  		:tax_included_price, presence: true
	validates :tax_included_price, :quantity, numericality: { only_integer: true }

	enum production_status: {"着手不可": 0,"製作待ち": 1,"製作中": 2,"製作完了": 3}

    def order_status_auto_update
        if self.production_status == "製作中"
            self.order.update_attributes(order_status: "製作中")
        end
    end

    def production_complete_auto_update
        order_details = self.order.order_details
        production_status = order_details.pluck(:production_status)
         if production_status.all?{ |production_status| production_status == "製作完了"}
            self.order.update_attributes(order_status: "発送準備中")
         end
    end

end
