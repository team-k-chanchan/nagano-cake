class Customer::OrdersController < ApplicationController
  include ApplicationHelper
  
  before_action :to_log, only: [:show]
  before_action :authenticate_customer!
  
  def new
  @order = Order.new
  @shipping_addresses = ShippingAddress.where(customer: current_customer)
  end
  
  def log
  @cart_items = current_cart
  @order = Order.new(customer: current_customer,payment_method: params[:order][:payment_method])
  
  @order.total_payment = billing(@order)
  
  # addressにresidenceの値がはいっていれば
  if params[:order][:addresses] == "residence"
  @order.postal_code = current_customer.postal_code
  @order.address     = current_customer.address
  @order.name        = current_customer.last_name + current_customer.first_name
  
  # addressにshipping_addressesの値がはいっていれば
  elsif params[:order][:addresses] == "shipping_addresses"
  ship = ShippingAddress.find(params[:order][:shipping_address_id])
  @order.postal_code = ship.postal_code
  @order.address     = ship.shipping_address
  @order.name        = ship.name
  
  # addressにnew_addressの値がはいっていれば
  elsif params[:order][:addresses] == "new_address"
  @order.postal_code = params[:order][:postal_code]
  @order.address     = params[:order][:address]
  @order.name        = params[:order][:name]
  @ship = "1"
  
    unless @order.valid? == true
      @shipping_addresses = ShippingAddress.where(customer: current_customer)
      render :new
    end
  
  end
  end
  
  def create
  @order = current_customer.orders.new(order_params)
  @order.save!
  flash[:notice] = "ご注文が確定しました。"
  redirect_to thanx_customer_orders_path
  
  # もし情報入力でnew_addressの場合ShippingAddressに保存
  if params[:order][:ship] == "1"
  current_customer.shipping_address.create(address_params)
  end
  
  # カート商品の情報を注文商品に移動
  @cart_items = current_cart
  @cart_items.each do |cart_item|
  @order_details = @order.order_details.new
  @order_details.item_id = cart_item.item.id
  @order_details.tax_included_price = cart_item.item.price
  @order_details.quantity = cart_item.quantity
  @order_details.save!
  end
  
  # 注文完了後、カート商品を空にする
  @cart_items.destroy_all
  end
  
  def thanx
  end
  
  def index
  @orders = current_customer.orders.page(params[:page]).per(5)
  end
  
  def show
  @order = Order.find(params[:id])
  @order_details = @order.order_details
  end
  
  private
  
  def order_params
  params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_payment)
  end
  
  def address_params
  params.require(:order).permit(:postal_code, :shipping_address, :name)
  end
  
  def to_log
  redirect_to customer_cart_items_path if params[:id] == "log"
  end
end
