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

require 'spec_helper'

describe Banner do

end
