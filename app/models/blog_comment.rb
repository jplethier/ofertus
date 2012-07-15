class BlogComment < ActiveRecord::Base
  belongs_to :blog_post
  belongs_to :user

  validates :name,      :presence => true
  validates :content,   :presence => true
  validates :title,     :length   => { :maximum => 50 }
  validates :blog_post, :presence => true
  validates :site,      :format   => /^https?:\/\/.+/, :allow_blank => true
  validates :email,     :format => /^[a-z0-9A-Z.]+@[a-z0-9A-Z]+\.[a-z0-9A-Z]{1,3}(\.[a-z0-9A-Z]+)?$/, :allow_blank => true
end
