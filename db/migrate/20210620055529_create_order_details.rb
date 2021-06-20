class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.integer :order_id
      t.integer :item_id
      t.integer :quantity
      t.string :production_status
      t.integer :tax_included_price

      t.timestamps
    end
  end
end
