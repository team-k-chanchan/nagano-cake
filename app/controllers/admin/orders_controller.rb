class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:customer_id].nil?
       @orders = Order.page(params[:page]).per(10).reverse_order
    else
       @orders = Order.where(customer_id: params[:customer_id]).page(params[:page]).per(10).reverse_order
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    flash[:success] = "注文ステータスを変更しました"
    order.order_detail_status_auto_update
    redirect_to admin_order_path(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end
end
