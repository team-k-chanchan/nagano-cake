class Order < ApplicationRecord
    has_many :items

    def self.tax_included_price(order_detail)
        @@result = order_detail.item.price*1.1
        return @@result.round(0)
    end

    def self.item_price_subtotal(order_detail)
        @@result_subtotal = @@result*order_detail.quentity
        return @@result_subtotal.round(0)
    end


    def order_detail_status_auto_update
        if self.order_status == "入金確認"
            self.order_details.each do |order_detail|
                order_detail.update_attributes(production_status: "制作待ち")
            end
            # 誤って入金確認を押した際に制作ステータスを再度「着手不可」へ戻すための記述
        elsif self.order_status == "入金待ち"
            self.order_details.each do |order_detail|
                order_detail.update_attributes(production_status: "着手不可")
            end
        end
    end



end
