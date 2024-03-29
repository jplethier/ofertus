# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  followed_id :integer          not null
#  follower_id :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Relationship do
  let(:relationship) { FactoryGirl.build :relationship }
  subject { relationship }

  its(:save) { should be_true }

  it { should respond_to :follower }
  it { should respond_to :followed }

  describe "Validations" do
    it "one should not be able to have a relationship with oneself" do
      relationship.followed = relationship.follower
      relationship.should_not be_valid
    end

    it "one should have only one relationship with another at most do" do
      same_relationship = FactoryGirl.create :relationship

      relationship.follower = same_relationship.follower
      relationship.followed = same_relationship.followed
      relationship.should_not be_valid
    end

    describe "#follower_id" do
      it "should not be blank" do
        relationship.follower = nil
        relationship.should_not be_valid
      end
    end

    describe "#followed_id" do
      it "should not be blank" do
        relationship.followed = nil
        relationship.should_not be_valid
      end
    end
  end

  describe 'followed_ids' do
    let(:follower) { relationship.follower }
    let(:followed1) { relationship.followed }

    it 'should return the followed id of a follower' do
      relationship.save
      Relationship.followed_ids(follower.id).should == [followed1.id]
      followed2 = FactoryGirl.create(:user)
      follower.follow! followed2
      Relationship.followed_ids(follower.id).should =~ [followed1.id, followed2.id]
    end
  end
end
