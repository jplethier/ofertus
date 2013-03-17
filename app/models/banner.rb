# == Schema Information
#
# Table name: banners
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  alt                :string(255)
#  image_content_type :string(255)
#  image_file_name    :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  url                :string(255)
#  target             :string(255)
#  active             :boolean
#  created_at         :datetime
#  updated_at         :datetime
#  icon_content_type  :string(255)
#  icon_file_name     :string(255)
#  icon_file_size     :integer
#  icon_updated_at    :datetime
#

class Banner < ActiveRecord::Base
  attr_accessible :active, :alt, :icon, :image, :target, :title, :url

  has_attached_file :image, styles: { medium: "300x300>", thumb: "110x90>", banner: "520x280>" }, default_url: "/images/banners/:style/missing.png", url: "banners/:id_partition/:style.:extension", path: "banners/:id_partition/:style.:extension"

  has_attached_file :icon, styles: { thumb: "110x90>" }, default_url: "/images/banners/icons/:style/missing.png", url: "banners/icons/:id_partition/:style.:extension", path: "banners/icons/:id_partition/:style.:extension"

  scope :active, lambda { where(active: true).order('created_at desc').limit(3) }
  scope :all_active, lambda { where(active: true) }
  scope :recent, lambda { order('created_at desc') }
end
