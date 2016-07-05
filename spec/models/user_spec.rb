require 'rails_helper'

RSpec.describe User, type: :model do
  it { should respond_to(:username) }
  it { should respond_to(:password) }

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zip) }

  it { should validate_uniqueness_of(:username) }

  it { should validate_confirmation_of(:password).with_message("does not match") }
  it { should validate_confirmation_of(:email).with_message("does not match") }

  scenario "user is not valid with bad attributes" do
    user = User.new(username: "admin", password: "admin")
    user_1 = User.new(username: "admin", password: "admin", email: "icorson@example.com")
    user_2 = User.new(username: "admin", password: "admin", email: "icorson@example.com", name: "ilana")
    user_3 = User.new(username: "admin", password: "admin", email: "icorson@example.com", name: "ilana", address: "8902 Lincoln Street")
    user_4 = User.new(username: "admin", password: "admin", email: "icorson@example.com", name: "ilana", address: "8902 Lincoln Street", city: "denver")
    user_5 = User.new(username: "admin", password: "admin", email: "icorson@example.com", name: "ilana", address: "8902 Lincoln Street", city: "denver", state: "CO")

    expect(user.save).to eq false
    expect(user_1.save).to eq false
    expect(user_2.save).to eq false
    expect(user_3.save).to eq false
    expect(user_4.save).to eq false
    expect(user_5.save).to eq false
  end

  it "can find all the open auctions for a specific user" do
    user = create(:user_with_bids)
    item1, item2, item3 = user.items
    item1.update(status: 1)

    expect(user.items.count).to eq(3)
    expect(user.open_items.count).to eq(2)
  end

  it "cannot find won auctions if the user has no bidders" do
      user = create(:user)
      expect(user.bids).to be_blank
      expect(user.won_items.count).to eq(0)
  end

  it "can identify a single auction won by a specific user" do
    user = create(:user_with_bids)

    item1, item2, item3 = user.items

    dup_bid = create(:bid, price: 1000, item: item1, user: user)
    item1.update(status: "closed")

    expect(user.won_items.count).to eq(1)
    expect(user.open_items.count).to eq(2)
    expect(user.closed_items.count).to eq(1)
  end

  it "can find a multiple auctions won by a specific user" do
    user = create(:user_with_bids)

    item1, item2, item3 = user.items

    item1.update(status: "closed")
    item2.update(status: "closed")

    expect(user.won_items.count).to eq(2)
    expect(user.open_items.count).to eq(1)
    expect(user.closed_items.count).to eq(2)
  end

  it "can find multiple auctions lost by a specific user" do

    user1 = create(:user_with_bids)

    item1, item2, item3 = user1.items

    dup_bid = create(:bid, price: 100, item: item1, user: user1)
    user2 = create(:user)
    create(:bid, price: 1000, user: user2, item: item1)

    item1.update(status: "closed")
    item2.update(status: "closed")

    expect(user1.won_items.count).to eq(1)
    expect(user2.won_items.count).to eq(1)

    expect(user1.lost_items.count).to eq(1)
    expect(user2.lost_items.count).to eq(0)

    expect(user1.open_items.count).to eq(1)
    expect(user2.open_items.count).to eq(0)
    expect(user1.closed_items.count).to eq(2)
    expect(user2.closed_items.count).to eq(1)
  end

  it "it can return a single item that has multiple bids from the same user" do
    user = create(:user_with_bid)
    item = user.items.last

    new_bid = create(:bid, price: 1000, user: user, item: item)

    expect(item.bids.count).to eq(2)

    expect(user.open_items.count).to eq(1)
  end

  it "can tell if it is a business_admin" do
    user = create(:user)
    user.businesses << create(:business, active: true)

    expect(user.admin?).to eq(true)
  end

  it "can tell if it is not a business_admin" do
    user = create(:user)

    expect(user.admin?).to eq(false)
  end
end
