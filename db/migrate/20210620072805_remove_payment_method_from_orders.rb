class RemovePaymentMethodFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :payment_method, :string
  end
end
