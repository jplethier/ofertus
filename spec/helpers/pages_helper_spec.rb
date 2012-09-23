# coding: UTF-8
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
describe PagesHelper do
  describe 'truncate name' do
    it 'should truncate at 21 if no length is passed' do
      helper.truncate_name('a'*22).should == 'a'*18 + '...'
    end

    it 'should not truncate if the length of the string is less then the length passed' do
      helper.truncate_name('a'*17).should == 'a'*17
      helper.truncate_name('a'*21).should == 'a'*21
      helper.truncate_name('a'*118, 121).should == 'a'*118
    end

    it 'should truncate at length if it passed' do
      helper.truncate_name('a'*100, 30).should == 'a'*27 + '...'
      helper.truncate_name('a'*100, 93).should == 'a'*90 + '...'
    end
  end
end