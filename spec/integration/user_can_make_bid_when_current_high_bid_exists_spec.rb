require 'rails_helper'

RSpec.feature "user can place a bid on an item when a bid already exists" do
  scenario "they create a second bid for an item" do
    item = create(:item)
    user1 = create(:user)
    user2 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit item_path(item)
    expect(page).to have_content("No bids yet")
    fill_in "bid[price]", with: "10.99"
    click_button("Place Bid")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

    visit item_path(item)
    expect(page).not_to have_content("No current bids")
    expect(page).to have_content("Highest Bidder: #{user1.username}")
    expect(page).to have_content("Highest Bid: $#{user1.bids.last.price}")

    fill_in "bid[price]", with: "15.99"
    click_button("Place Bid")
    expect(page).to have_content("Highest Bidder: #{user2.username}")
    expect(page).to have_content("Highest Bid: $#{user2.bids.last.price}")

    expect(page).not_to have_content("Highest Bid: #{user1.bids.last.price}")
  end


  scenario "they create a second bid for an item lower than the first" do
    item = create(:item)
    user1 = create(:user)
    user2 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit item_path(item)
    expect(page).to have_content("No bids yet")
    fill_in "bid[price]", with: "10.99"
    click_button("Place Bid")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

    visit item_path(item)
    expect(page).not_to have_content("No bids yet")
    expect(page).to have_content("Highest Bidder: #{user1.username}")
    expect(page).to have_content("Highest Bid: $#{user1.bids.last.price}")

    fill_in "bid[price]", with: "4.99"
    click_button("Place Bid")
    expect(page).not_to have_content("Highest Bid: 4.99")
  end



end
