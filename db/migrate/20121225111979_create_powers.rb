class CreatePowers < ActiveRecord::Migration
  def change
    create_table :powers do |t|
      t.integer :user_id
      t.integer :quantity
      t.integer :status

      t.timestamps
    end
  end
end
