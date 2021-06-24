class RemoveCountFromCartItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :cart_items, :count, :integer
  end
end
