class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :description
      t.string :category
      t.integer :quantity
      t.float :value

      t.timestamps
    end
  end
end
