class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :category
      t.text :description
      t.float :price
      t.string :author

      t.timestamps
    end
  end
end
