class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
            t.string :name
            t.text :introduction
            t.string :image_id
            t.integer :price
            t.string :sales_status
            t.integer :genre_id
      t.timestamps
    end
  end
end
