class RemoveSalesStatusDeleteFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :sales_status, :integer
  end
end
