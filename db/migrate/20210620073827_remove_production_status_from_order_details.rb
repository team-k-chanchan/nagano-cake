class RemoveProductionStatusFromOrderDetails < ActiveRecord::Migration[5.2]
  def change
    remove_column :order_details, :production_status, :string
  end
end
