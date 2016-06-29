require 'rails_helper'

RSpec.describe Bid, type: :model do

  let(:bid_instance) { build(:bid) }

  it "has a valid factory" do
    expect(bid_instance).to be_valid
  end

  context "validations" do
    it { expect(bid_instance).to respond_to(:user) }
    it { expect(bid_instance).to respond_to(:item) }
  end

end
