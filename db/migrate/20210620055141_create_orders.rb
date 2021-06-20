class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :name
      t.text :postal_code
      t.string :address
      t.integer :shipping_cost
      t.string :total_payment
      t.string :payment_method
      t.string :order_status

      t.timestamps
    end
  end
end
