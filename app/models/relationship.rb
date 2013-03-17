# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  followed_id :integer          not null
#  follower_id :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

require 'not_equal_validator'

class Relationship < ActiveRecord::Base
  belongs_to :follower, :class_name => "User"
  belongs_to :followed, :class_name => "User"

  validates :followed_id, :presence => true, :uniqueness => { :scope => :follower_id }
  validates :follower_id, :presence => true, :not_equal => { :with => :followed_id, :message => "You cannot follow yourself" }

  def self.followed_ids(user_id)
    where(:follower_id => user_id).select(:followed_id).collect(&:followed_id)
  end
end
