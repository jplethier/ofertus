class ChangeAccessTokenToText < ActiveRecord::Migration
  def change
    change_column :users, :access_token, :text
  end
end
