class AddPaymentMthodToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :payment_method, :integer, default: 0
  end
end
