require 'rails_helper'

RSpec.feature "user sees auction info on their dashboard" do
  scenario "they visit their dashboard to see their data" do
    user = create(:user_with_bids)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    item_open = user.items.first
    item_won = user.items[1]
    item_won.update_attributes(status: 1)
    item_lost = user.items.last
    item_lost.update_attributes(status: 2)

    visit dashboard_path

    expect(page).to have_content("Welcome, #{user.name}")

    within("#open_auction") do
      expect(page).to have_content("Open Auctions")
      expect(page).to have_link(item_open.name)
      expect(page).to have_content(item_open.high_bid)
      expect(page).to have_content(item_open.high_bidder.username)
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
