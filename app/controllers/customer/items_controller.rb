class Customer::ItemsController < ApplicationController
    
    def index
        @items = Item.where(sales_status: 0).page(params[:page]).per(8)
    end
    
end
