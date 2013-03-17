# == Schema Information
#
# Table name: errors
#
#  id         :integer          not null, primary key
#  model_name :string(255)
#  message    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Error < ActiveRecord::Base
end
