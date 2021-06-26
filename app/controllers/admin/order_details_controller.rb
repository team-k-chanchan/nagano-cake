class Admin::OrderDetailsController < ApplicationController
  def update
    order_detail = OrderDetail.find(params[:id])
    order = order_detail.order
    if order.order_status != "入金待ち"
      order_detail.update(order_detail_params)
      order_detail.order_status_auto_update
      order_detail.production_complete_auto_update
      redirect_to admin_order_path(order)
    else
      flash[:alert] = "注文ステータスが「入金待ち」の為、変更できません"
      redirect_to admin_order_path(order)
    end

  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end
end
