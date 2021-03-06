require 'rails_helper'

RSpec.feature "user can view business index" do
  scenario "user visits home page and sees the business index link" do
    visit root_url

    within ("#category-nav") do
      expect(page).to have_link("Browse By Business")
    end
  end

  scenario "user clicks 'Browse By Business' link on home page" do

    businesses = create_list(:business, 3, active: true)
    visit root_url

    click_link "Browse By Business"
    within ('#site_content') do
      expect(current_path).to eq(businesses_path)
      expect(page).to have_link(businesses[0].name)
      expect(page).to have_link(businesses[1].name)
      expect(page).to have_link(businesses[2].name)
    end
  end

  scenario "inactive businesses do not appear on the index" do

    businesses = create_list(:business, 2, active: true)
    businesses << create(:business)
    visit root_url

    click_link "Browse By Business"
    within ('#site_content') do
      expect(current_path).to eq(businesses_path)
      expect(page).to have_link(businesses[0].name)
      expect(page).to have_link(businesses[1].name)
      expect(page).to have_no_link(businesses[2].name)
    end
  end

  scenario "user clicks on a link to be taken to a business show page" do
    business1 = create(:business, active: true)
    business2 = create(:business, active: true)

    items1 = create_list(:item, 3)
    business1.items << items1
    items2 = create_list(:item, 3)
    business2.items << items2

    visit businesses_path

    click_link(business1.name)
    expect(current_path).to eq(business_path(slug: "#{business1.slug}"))
    within('#site_content') do
      expect(page).to have_content(business1.name)
      expect(page).to have_content(items1[0].name)
      expect(page).to have_content(items1[1].name)
      expect(page).to have_content(items1[2].name)
      expect(page).to have_no_content(items2[0].name)
      expect(page).to have_no_content(items2[1].name)
      expect(page).to have_no_content(items2[2].name)
    end
  end

end
