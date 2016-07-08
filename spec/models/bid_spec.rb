require 'rails_helper'

RSpec.describe Bid, type: :model do

  let(:bid_instance) { build(:bid) }

  it "has a valid factory" do
    expect(bid_instance).to be_valid
  end

  describe "bid should have the correct attributes" do
    it { expect(bid_instance).to respond_to(:user) }
    it { expect(bid_instance).to respond_to(:user) }
  end

  describe "bid has the correct associations" do
    it { expect(bid_instance).to belong_to(:user) }
    it { expect(bid_instance).to belong_to(:item) }
  end

 describe "bid validates attributes" do
    it { expect(bid_instance).to validate_presence_of(:user) }
    it { expect(bid_instance).to validate_presence_of(:item) }
    it { expect(bid_instance).to validate_presence_of(:price) }

    it do
      expect(bid_instance).to validate_uniqueness_of(:price).
         scoped_to(:user_id, :item_id)
    end
 end
end

