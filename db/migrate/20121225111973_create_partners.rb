class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.float :commission
      t.string :name
      t.integer :code

      t.timestamps
    end
  end
end
