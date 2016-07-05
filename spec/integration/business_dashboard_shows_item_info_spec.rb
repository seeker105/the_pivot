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
    admin = create(:user)
    admin.businesses << create(:business)
    business = admin.businesses.first
    business.items << create(:item)
    business.items << create(:item, status: "closed")
    open_item = business.items.first
    closed_item = business.items.last

    other_business = create(:business)
    other_business.items << create(:item, status: "closed")
    other_item = other_business.items.first

    visit business_dashboard_path(business.slug)

    within("#open_auction") do
      expect(page).to have_content(open_item.name)
      expect(page).to have_content(open_item.high_bid)
      expect(page).to have_content(open_item.high_bidder)
      expect(page).to have_content(open_item.end_time)

      expect(page).not_to have_content(closed_item.name)
    end

    within("#closed_auction") do
      expect(page).to have_content(closed_item.name)
      expect(page).to have_content(closed_item.high_bid)
      expect(page).to have_content(closed_item.high_bidder)
      expect(page).to have_content(closed_item.end_time)

      expect(page).not_to have_content(open_item.name)
      expect(page).not_to have_content(other_item.name)
    end
  end
end
