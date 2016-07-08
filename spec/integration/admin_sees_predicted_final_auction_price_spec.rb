require 'rails_helper'

RSpec.feature "admin sees predicted final auction price" do
  scenario "for an item with 3 bids" do
    admin = create(:user)
    time = DateTime.now
    item = create(:item, created_at: time, price: 0, end_time: time + 20.second)
    bid1 = create(:bid, created_at: time + 5.second , price: 1, item: item)
    bid2 = create(:bid, created_at: time + 10.second, price: 3, item: item)
    bid3 = create(:bid, created_at: time + 15.second, price: 6, item: item)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit item_path(item)

    within("#item_details") do
      expect(page).to have_content("Predicted Selling Price: $7")
    end
  end

  scenario "for an item with less than 3 bids" do
    admin = create(:user)
    time = DateTime.now
    item = create(:item, created_at: time, price: 0, end_time: time + 20.second)
    bid1 = create(:bid, created_at: time + 5.second , price: 1, item: item)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit item_path(item)

    within("#item_details") do
      expect(page).to have_content("Predicted Selling Price: Not enough bids yet to make prediction")
    end
  end
end
