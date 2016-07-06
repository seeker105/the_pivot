require 'rails_helper'

RSpec.feature "user can place a bid on an item" do
  context "user not logged in" do

    scenario "guest user cannot see bid form" do
      item = create(:item)
      visit item_path(item)
      within ("#bid_form") do
        expect(page).to have_content("Login or Create Account to Bid")
      end
    end

    scenario "guest user is redirected to back to the item after logging in" do
      item = create(:item)
      user = create(:user)
      visit item_path(item)
      click_link "Login or Create Account to Bid"

      fill_in "Username", with: user.username
      fill_in "Password", with: user.password

      click_button "Log In"

      expect(current_path).to eq(item_path(item))

      within("#new_bid") do
        expect(page).to have_button("Place Bid")
      end
    end
  end

  context "user is logged in" do
    scenario "they create the first bid for the item" do
      user = create(:user)
      item = create(:item)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit item_path(item)

      expect(page).to have_content("No current bids")
      fill_in "bid[price]", with: "10.99"
      click_button("Place Bid")

      expect(page).not_to have_content("No current bids")
      expect(page).to have_content("Highest Bidder: #{user.username}")
      expect(page).to have_content("Highest Bid: $#{user.bids.last.price}")
    end

    scenario "user cannot place the same bid twice on a specific item" do
      user = create(:user)
      item1 = create(:item)
      item2 = create(:item)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit item_path(item1)

      expect(page).to have_content("No current bids")
      fill_in "bid[price]", with: "10.99"
      click_button("Place Bid")

      fill_in "bid[price]", with: "10.99"
      click_button("Place Bid")

      expect(page).to have_content("Price has already been taken")

      visit item_path(item2)
      expect(page).to have_content("No current bids")
      fill_in "bid[price]", with: "10.99"
      click_button("Place Bid")

      expect(page).to_not have_content("Price has already been taken")
      expect(page).to have_content("Highest Bidder: #{user.username}")
      expect(page).to have_content("Highest Bid: $10.99")
    end
  end
end
