class AddSalesStatusAddToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :sales_status, :boolean, default: true, null: false
  end
end
