require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the DealsHelper. For example:
#
# describe DealsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe DealsHelper do
  describe 'price to currency' do
    it 'should show the price in the correct currency format' do
      helper.price_to_currency(1.19).should == 'R$ <strong>1</strong>,19'
      helper.price_to_currency(1).should == 'R$ <strong>1</strong>,00'
      helper.price_to_currency(1000).should == 'R$ <strong>1.000</strong>,00'
      helper.price_to_currency(-5).should == '-R$<strong>5</strong>,00'
    end
  end
end