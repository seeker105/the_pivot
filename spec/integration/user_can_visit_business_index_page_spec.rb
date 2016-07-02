require 'rails_helper'

RSpec.feature "user can view business index" do
  scenario "user visits home page and sees the business index link" do
    visit root_url

    expect(page).to have_link("Business Index")
  end

  scenario "user clicks 'Business Index' link on home page" do
    businesses = create_list(:business, 3)
    visit root_url

    click_link "Business Index"
    expect(current_path).to eq(businesses_path)
    expect(page).to have_link(businesses[0].name)
    expect(page).to have_link(businesses[1].name)
    expect(page).to have_link(businesses[2].name)
  end

  scenario "user clicks on a link to be taken to a business show page" do
    businesses = create_list(:business, 2)
    business = businesses[0]
    items = create_list(:item, 3)
    business.items << items

    visit businesses_path

    click_link(business.name)
    expect(current_path).to eq(business_path(id: business.id))
    expect(page).to have_content(business.name)
    expect(page).to have_content(items[0].name)
    expect(page).to have_content(items[1].name)
    expect(page).to have_content(items[2].name)
  end

end
