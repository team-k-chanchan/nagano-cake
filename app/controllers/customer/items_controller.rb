class Customer::ItemsController < ApplicationController


    def index
        @items = Item.where(sales_status: 0).page(params[:page]).per(8)
        @count = Item.count
    end

    def show
        @item = Item.find(params[:id])
        @cart_item = CartItem.new
    end

end
