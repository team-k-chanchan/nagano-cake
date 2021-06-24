class ChangeShippingCostOfOrders < ActiveRecord::Migration[5.2]
  
  def up
    change_column :orders, :shipping_cost, :integer, default: 800
  end
  
  def down
    cgange_column :orders, :shipping_cost, :integer
  end
  
end
