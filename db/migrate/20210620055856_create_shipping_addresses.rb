class CreateShippingAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_addresses do |t|
      t.integer :customer_id
      t.string :name
      t.string :postal_code
      t.text :shipping_address

      t.timestamps
    end
  end
end
