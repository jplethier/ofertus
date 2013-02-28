class Notification < ActiveRecord::Base
  attr_protected :id

  UNREAD  = 1
  READ    = 2
  DELETED = 3

  belongs_to :user

  default_scope order('created_at DESC')

  scope :unread,  where(status: 1)
  scope :read,    where(status: 2)
  scope :deleted, where(status: 3)
  scope :admin,   where(user_id: nil)

  before_create :set_unread

  def set_unread
    self.status = Notification::UNREAD
    true
  end

  def mark_as_read
    self.update_attributes(status: Notification::READ)
  end

  def self.i18n_status(status)
    I18n.t("models.deal.category.#{status}")
  end
end
