class AddProductionStatusToOrderDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :order_details, :production_status, :integer, default: 0
  end
end
