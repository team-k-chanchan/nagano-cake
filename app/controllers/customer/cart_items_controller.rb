class Customer::CartItemsController < ApplicationController
     before_action :authenticate_customer!
    
    def index
        @cart_items = current_customer.cart_items
    end
    
    def update
        @cart_item = CartItem.find(params[:id])
        @cart_item.update(cart_item_params)
        redirect_to customer_cart_items_path
    end
    
    def create
         @cart_item = CartItem.new(cart_item_params)
         @cart_item.customer_id = current_customer.id
         @update_cart_item = CartItem.find_by(item_id: @cart_item.item_id, customer_id: @cart_item.customer_id)
      if @update_cart_item.present?
         @update_num = @update_cart_item.quantity += @cart_item.quantity
         @update_cart_item.update(quantity: @update_num)
         redirect_to customer_cart_items_path
      elsif @cart_item.save
         redirect_to customer_cart_items_path
      else
         @item = Item.find(params[:cart_item][:item_id])
      end
    end
    
    def destroy
        @cart_item = CartItem.find(params[:id])
        @cart_item.destroy
        redirect_to customer_cart_items_path
    end
    
    def destroy_all
        @cart_items = current_customer.cart_items
        @cart_items.destroy_all
        redirect_to customer_cart_items_path
    end

    
    private
    
    def cart_item_params
        params.require(:cart_item).permit(:quantity, :item_id, :customer_id )
    end
    
end
