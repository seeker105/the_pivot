require 'rails_helper'

RSpec.feature "display auction dashboard" do
  scenario "User makes a single bid and sees it in the active auction table" do
    user = create(:user_with_bid)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    item = user.items.first

    visit dashboard_path
    expect(page).to_not have_content("No auction information yet!")

    within("#open_auction") do
      expect(page).to have_content("Open Auctions")
      expect(page).to have_link(item.name)
      expect(page).to have_content("Current High Bid")
      expect(page).to have_content(item.high_bid)
      expect(page).to have_content("Current High Bidder")
      expect(page).to have_content(item.high_bidder.username)
      expect(page).to have_content("Auction End Date")
      expect(page).to have_content(item.end_time.strftime("%b %e, %l:%M %p %Z"))
    end
  end

  scenario "User has no bids and sees nothing on their dashboard" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    expect(user.bids.count).to eq(0)

    visit dashboard_path

    expect(page).to have_content("No auction information yet!")

    expect(page).to_not have_content("Open Auctions")
    expect(page).to_not have_content("Auctions Won")
    expect(page).to_not have_content("Closed Auctions")
  end

  scenario "user wins an auction and sees item in the won auctions table" do
    user = create(:user_with_bids)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    item1, item2, item3 = user.items
    item_won = item1.tap { |item| item.update(status: "closed") }

    expect(item_won.status).to eq("closed")

    visit dashboard_path

    within("#won_auction") do
      expect(page).to have_content("Auctions Won")
      expect(page).to have_link(item_won.name)
      expect(page).to have_content("Price Paid")
      expect(page).to have_content(item_won.high_bid)
      expect(page).to have_content("Payment Date")
      expect(page).to have_content(item_won.end_time.strftime("%b %e, %l:%M %p %Z"))

      expect(page).not_to have_content(item2.name)
      expect(page).not_to have_content(item3.name)
    end
  end

  scenario "user loses an auction and sees item in the lost auctions table" do
    user = create(:user_with_bids)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    item1, item2, item3 = user.items

    user2 = create(:user)
    create(:bid, price: 100, user: user2, item: item1)

    item_lost = item1.tap { |item| item.update(status: "closed") }

    expect(item_lost.status).to eq("closed")

    visit dashboard_path

    within("#lost_auction") do
      expect(page).to have_content("Auctions Lost")
      expect(page).to have_content(item_lost.name)
      expect(page).to have_content("Date Auction Closed")
      expect(page).to have_content(item_lost.end_time.strftime("%b %e, %l:%M %p %Z"))
      expect(page).not_to have_content(item2.name)
      expect(page).not_to have_content(item3.name)
    end
  end
end
