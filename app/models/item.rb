class Item < ApplicationRecord
    #アソシエーション
    has_many :cart_items
    has_many :orders, through: :order_details
    has_many :order_details
    belongs_to :genre

    #画像用の設定
    attachment :image



    #バリデーション
    validates :name, presence: true
    validates :introduction, presence: true
    validates :price, presence: true
    validates :genre, presence: true
end
