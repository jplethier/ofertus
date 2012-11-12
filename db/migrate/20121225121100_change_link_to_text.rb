class ChangeLinkToText < ActiveRecord::Migration
  def change
    change_column :deals, :link, :text
    puts 'asdasdasd'
    change_column :deals, :original_link, :text
    # add_column :deals, :abc, :text
    # remove_column :deals, :abc
  end
end
