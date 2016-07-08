require 'rails_helper'

RSpec.feature "item bid info display" do
  scenario "for an open item with no bids" do
    item = create(:item)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit item_path(item)

    within("#clock-container") { expect(page).to have_css("#clockdiv") }
    within("#item_details") do
      expect(page).to have_content("Highest Bid: No bids yet")
      expect(page).to have_content("Highest Bidder: No high bidder yet")
      expect(page).to have_content("Predicted Selling Price")
      expect(page).to have_button("Place Bid")
    end
  end

  scenario "for an open item with bids" do
    item = create(:item)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    bid = create(:bid, item: item, user: user)

    visit item_path(item)

    within("#clock-container") { expect(page).to have_css("#clockdiv") }
    within("#item_details") do
      expect(page).to have_content("Highest Bid: $#{bid.price}")
      expect(page).to have_content("Highest Bidder: #{user.username}")
      expect(page).to have_content("Predicted Selling Price")
      expect(page).to have_button("Place Bid")
    end
  end

  scenario "for a closed item" do
    item = create(:item, status: "closed")
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    bid = create(:bid, item: item, user: user)

    visit item_path(item)

    within("#clock-container") { expect(page).to_not have_css("#clockdiv") }
    within("#item_details") do
      expect(page).not_to have_content("Highest Bid: $#{bid.price}")
      expect(page).not_to have_content("Highest Bidder: #{user.username}")
      expect(page).not_to have_content("Predicted Selling Price")
      expect(page).not_to have_button("Place bid")

      expect(page).to have_content("This item's auction has ended")
    end
  end
end
