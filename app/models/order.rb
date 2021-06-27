class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items

	validates :customer_id, :address,:name, :shipping_cost,
			  		:total_payment, :payment_method,
			  		presence: true
	validates :postal_code, length: {is: 7}, numericality: { only_integer: true }
	validates :shipping_cost, :total_payment, numericality: { only_integer: true }

	enum payment_method: {"クレジットカード": 0,"銀行振込": 1}
	enum order_status: {"入金待ち": 0,"入金確認": 1,"製作中": 2,"発送準備中": 3, "発送済み": 4}

    def self.tax_included_price(order_detail)
        @@result = order_detail.item.price*1.1
        return @@result.round(0)
    end

  def self.item_price_subtotal(order_detail)
        @@result_subtotal = @@result*order_detail.quantity
        return @@result_subtotal.round(0)
  end


  def order_detail_status_auto_update
        if self.order_status == "入金確認"
            self.order_details.each do |order_detail|
                order_detail.update_attributes(production_status: "製作待ち")
            end
            # 誤って入金確認を押した際に制作ステータスを再度「着手不可」へ戻すための記述
        elsif self.order_status == "入金待ち"
            self.order_details.each do |order_detail|
                order_detail.update_attributes(production_status: "着手不可")
            end
        end
  end
end
