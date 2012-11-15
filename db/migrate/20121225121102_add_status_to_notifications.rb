class AddStatusToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :status, :integer
  end
end
