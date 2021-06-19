class Item < ApplicationRecord
    #アソシエーション
    has_many :cart_items
    has_many :order_details
    belongs_to :genre
    
    #画像用の設定
    attachment :image
    
    #enumの設定
    enum sales_status: {販売中:0,販売停止:1}
    
    #バリデーション
    validates :name, presence: true
    validates :introduction, presence: true
    validates :price, prisence: true
end
