require 'rails_helper'

RSpec.feature "business dashboard shows item info" do
  scenario "for a business with no items" do
    business = create(:business)

    visit business_dashboard_path(business.slug)

    within(".business_items") do
      expect(page).to have_content("There are no items for this business yet")
    end
  end

  scenario "for a business with open auctions" do
    business = create(:business)
    items = business.items << create_list(:item, 2)
    extra_item = create(:item)

    visit business_dashboard_path(business.slug)
    save_and_open_page

    within('#open_auction') do
      expect(page).to have_content(items[0].name)
      expect(page).to have_content(items[0].high_bid)
      expect(page).to have_content(items[0].high_bidder)
      expect(page).to have_content(items[0].end_time)

      expect(page).to have_content(items[1].name)
      expect(page).to have_content(items[1].high_bid)
      expect(page).to have_content(items[1].high_bidder)
      expect(page).to have_content(items[1].end_time)

      expect(page).not_to have_content(extra_item.name)
    end
  end

  scenario "for a business with open and closed auctions" do

  end 
end
