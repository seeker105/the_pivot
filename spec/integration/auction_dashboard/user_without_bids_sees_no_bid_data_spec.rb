
require 'rails_helper'

RSpec.feature "user without bids" do

  scenario "sees nothing on their dashboard" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    expect(user.bids.count).to eq(0)

    visit dashboard_path

    save_and_open_page

    expect(page).to have_content("No auction information yet!")
    
    expect(page).to_not have_content("Open Auctions")
    expect(page).to_not have_content("Auctions Won")
    expect(page).to_not have_content("Closed Auctions")

  end

end
