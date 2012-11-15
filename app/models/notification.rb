class Notification < ActiveRecord::Base
  attr_protected :id

  UNREAD  = 1
  READ    = 2
  DELETED = 3

  belongs_to :user

  scope :unread,  where(status: 1)
  scope :read,    where(status: 2)
  scope :deleted, where(status: 3)

  before_create :set_unread

  def set_unread
    self.status = Notification::UNREAD
    true
  end

  def mark_as_read
    self.update_attributes(status: Notification::READ)
  end
end
