class Banner < ActiveRecord::Base
  attr_accessible :active, :alt, :image, :target, :title, :url

  has_attached_file :image,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: "/images/banners/:style/missing.png",
                    url: "banners/:id_partition/:style.:extension",
                    path: "banners/:id_partition/:style.:extension"
end
