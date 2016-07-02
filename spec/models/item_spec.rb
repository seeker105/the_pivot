require 'rails_helper'

RSpec.describe Item, type: :model do
  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
  end

  context "relationships" do
    it { should have_many(:categories_items) }
    it { should have_many(:categories) }
    it { should belong_to(:business)}
  end

  scenario "open and closed statuses" do
    item = create(:item)
    expect(item.open?).to eq true
    expect(item.closed?).to eq false

    retired_item = create(:item, status: 1)
    expect(retired_item.closed?).to eq true
    expect(retired_item.open?).to eq false
  end

  scenario "no item is created in db without passing validations" do
    item = Item.new(name: "thingy")
    expect(item.save).to eq false
    expect(Item.count).to eq(0)

    item = Item.new(name: "thingy", description: "it's great")
    expect(item.save).to eq false
    expect(Item.count).to eq(0)

    item = Item.new(name: "thingy", price: "12")
    expect(item.save).to eq false
    expect(Item.count).to eq(0)


    item = Item.new(description: "it's great", price: "12")
    expect(item.save).to eq false
    expect(Item.count).to eq(0)
  end

  it "returns the current highest bid" do
    item = create(:item)
    user = create(:user)

    bid1 = item.bids.create(price: 10.00, user: user)
    expect(item.high_bid).to eq 10.00

    bid2 = item.bids.create(price: 15.00, user: user)
    expect(item.high_bid).to eq 15.00

    bid3 = item.bids.create(price: 20.00, user: user)
    expect(item.high_bid).to eq 20.00
  end

  it "returns 0.0 for high_bid when no bids have been placed" do
    item = create(:item)
    user = create(:user)

    expect(item.high_bid).to eq 0.0
  end

  it "returns the current highest bidder" do
    item = create(:item)
    user1 = create(:user)
    user2 = create(:user)
    user3 = create(:user)

    bid1 = item.bids.create(price: 10.00, user: user1)
    expect(item.high_bidder).to eq user1

    bid2 = item.bids.create(price: 15.00, user: user2)
    expect(item.high_bidder).to eq user2

    bid3 = item.bids.create(price: 20.00, user: user3)
    expect(item.high_bidder).to eq user3
  end

  it "returns nil for high_bidder when no bids placed" do
    item = create(:item)
    user = create(:user)

    expect(item.high_bidder).to eq nil
  end

  it "changes the status of items whose auctions are elapsed to closed" do
    item1 = create(:item, status:  0, end_time: DateTime.now.at_beginning_of_day)
    item2 = create(:item, status:  0, end_time: DateTime.now.at_beginning_of_day + 24.hour)

    Item.update_status

    expect(Item.first.status).to eq("closed")
    expect(Item.last.status).to eq("open")
  end
end
