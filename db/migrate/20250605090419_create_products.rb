class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :code
      t.string :name
      t.decimal :price, precision: 7, scale: 2

      t.timestamps
    end
    add_index :products, :code, unique: true
  end
end
