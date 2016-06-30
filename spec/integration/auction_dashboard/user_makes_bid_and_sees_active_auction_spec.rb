require 'rails_helper'

RSpec.feature "user makes bid" do
  scenario "and sees active auction information on dashboard" do
    user = create(:user_with_bid)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    item = user.items.first

    visit dashboard_path
    expect(page).to_not have_content("No auction information yet!")

    within("#open_auction") do
      expect(page).to have_content("Open Auctions")
      expect(page).to have_link(item.name)
      expect(page).to have_content(item.high_bid)
      expect(page).to have_content(item.high_bidder.username)
    end

    # expect(page).to_not have_content("Auctions Won")
    # expect(page).to_not have_content("Closed Auctions")
  end
end


