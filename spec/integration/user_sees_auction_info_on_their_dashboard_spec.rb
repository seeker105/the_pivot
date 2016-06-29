require 'rails_helper'

RSpec.feature "user sees auction info on their dashbaord" do
  scenario "they visit their dashboard to see their data" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    item_open = create(:item_with_bids)
    # bid_a = user.bids.create(price: )
    item_won = create(:item_with_bids, status: 1)

    item_lost = create(:item_with_bids, status: 2)
    byebug
    visit dashboard_path

    expect(page).to have_content("Welcome, #{user.username}")

    within("#open_auction") do
      expect(page).to have_content("Open Auctions")
      expect(page).to have_link(item_open.name)
      expect(page).to have_content(item_open.high_bid)
      expect(page).to have_content(item_open.high_bidder)
    end

    within("#won_auction") do
      expect(page).to have_content("Auctions Won")
      expect(page).to have_content(item_won.name)
      expect(page).to have_content(item_won.price)
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
end
