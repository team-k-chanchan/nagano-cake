module Customer::ItemsHelper
    
    # 税込の計算
    def tax_price(price)
      (price*1.1).floor
    end
    
end
