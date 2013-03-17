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

require 'spec_helper'

describe Error do
  pending "add some examples to (or delete) #{__FILE__}"
end
