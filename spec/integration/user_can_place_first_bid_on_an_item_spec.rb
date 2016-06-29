require 'rails_helper'

RSpec.feature "user can place a bid on an item spec" do
  scenario "they create a new bid for the item" do
    user = create(:user)
    item = create(:item)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit item_path(item)

    expect(page).to have_content("No current bids")
    fill_in "bid[price]", with: "10.99"
    click_button("Place Bid")

    expect(page).not_to have_content("No current bids")
    expect(page).to have_content("Highest Bidder: #{user.name}")
    expect(page).to have_content("Highest Bid: #{user.bids.last.price}")
  end
end
