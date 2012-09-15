class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.float :value
      t.integer :commission
      t.integer :store
      t.string :affiliate
      t.string :country
      t.integer :user
      t.integer :transaction

      t.timestamps
    end
  end
end
