class Banner < ActiveRecord::Base
  attr_accessible :active, :alt, :icon, :image, :target, :title, :url

  has_attached_file :image, styles: { medium: "300x300>", thumb: "110x90>", banner: "520x280>" }, default_url: "/images/banners/:style/missing.png", url: "banners/:id_partition/:style.:extension", path: "banners/:id_partition/:style.:extension"

  has_attached_file :icon, styles: { thumb: "110x90>" }, default_url: "/images/banners/icons/:style/missing.png", url: "banners/icons/:id_partition/:style.:extension", path: "banners/icons/:id_partition/:style.:extension"

  scope :active, lambda { where(active: true).order('created_at desc').limit(3) }
  scope :all_active, lambda { where(active: true) }
  scope :recent, lambda { order('created_at desc') }
end
