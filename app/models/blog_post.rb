class BlogPost < ActiveRecord::Base

  before_save :create_post_url
  
  belongs_to :user

  validates :title,   :presence => true, :length => { :maximum => 100 }
  validates :content, :presence => true, :length => { :maximum => 10000 }
  validates :user,    :presence => true
  validates :url,     :presence => true

  def create_post_url
    self.url = self.title.parameterize
  end
end
