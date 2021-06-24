class OrderDetail < ApplicationRecord

    def order_status_auto_update
        if self.production_status == "制作中"
            self.order.update_attributes(status: "制作中")
        end
    end

    def production_complete_auto_update
        order_details = self.order.order_details
        production_status = order_details.pluck(:production_status)
         if production_status.all?{ |production_status| production_status == "制作完了"}
            self.order.update_attributes(status: "発送準備中")
         end
    end

end
