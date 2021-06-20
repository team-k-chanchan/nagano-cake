class AddSalesStatusToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :sales_status, :integer, default: 0
  end
end
