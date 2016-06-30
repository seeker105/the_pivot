require 'rails_helper'

RSpec.feature "user sees auction info on their dashboard" do

  scenario "user with no bids sees nothing on their dashboard" do
    user = create(:user)
    # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    # setup_user_is_high_bidder

    expect(user.bids.count).to eq(0)
    
  end

  scenario "user wins an auction and sees a single item in the won auctions table" do
    pending
    # # setup_user_is_high_bidder
    # item = Item.last
    # expect(item.status).to eq("open")
    # Item.update_status
    # byebug
    # expect(item.status).to eq("closed")


  end

  scenario "user loses an auction and sees item in the lost auctions table" do
    pending
  end

  scenario "user bids on an item and sees item in the active auctions table" do
    pending
  end

  scenario "they visit their dashboard to see their data" do
    pending

    # user = create(:user_with_bid)
    #allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)
    
   item_open = user.items.first
    item_won = user.items[1]
    item_won.update_attributes(status: 1)
    #and the current user was the high bidder

    # item_lost = user.items.last
    # item_lost.update_attributes(status: 2)

    visit dashboard_path

    expect(page).to have_content("Welcome, #{user.name}")

    within("#open_auction") do
      expect(page).to have_content("Open Auctions")
      expect(page).to have_link(item_open.name)
      expect(page).to have_content(item_open.high_bid)
      expect(page).to have_content(item_open.high_bidder.username)
      expect(page).not_to have_content(item_lost.name)
      expect(page).not_to have_content(item_won.name)
    end

    within("#won_auction") do
      expect(page).to have_content("Auctions Won")
      expect(page).to have_link(item_won.name)
      expect(page).to have_content(item_won.hig_bid)
      expect(page).not_to have_content(item_open.name)
      expect(page).not_to have_content(item_lost.name)
    end

    within("#closed_auction") do
      expect(page).to have_content("Closed Auctions")
      expect(page).to have_content(item_lost.name)
      expect(page).to have_content(item_lost.name)
      expect(page).not_to have_content(item_open.name)
      expect(page).not_to have_content(item_won.name)
    end

  end

    def setup_user_is_high_bidder
      item = create(:item)

      user1 = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
      bid1 = Bid.create(user: user1, item: item, price: 10)

      user2 = create(:user)
      bid2 = Bid.create(user: user2, item: item, price: 11)

      #item.update_attributes(status: 1)
      #Item.update_status
    end

    def lose_item
      item = create(:item)

      user2 = create(:user)
      bid2 = Bid.create(user_id: user2, item_id: item, price: 11)

      user1 = create(:user)
      bid1 = Bid.create(user_id: user1, item_id: item, price: 12)
      
      item.update_attributes(status: 1)
    end

    def ongoing_auction
      item = create(:item)
      user1 = create(:user)
      
      # User bids on it
      # Auction is still open
    end
end
