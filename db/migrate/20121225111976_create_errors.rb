class CreateErrors < ActiveRecord::Migration
  def change
    create_table :errors do |t|
      t.string :model_name
      t.string :message

      t.timestamps
    end
  end
end
