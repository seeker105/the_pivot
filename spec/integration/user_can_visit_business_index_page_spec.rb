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
    expect(current_path).to eq(business_index_path)
    expect(page).to have_link(businesses[0.name])
    expect(page).to have_link(businesses[1.name])
    expect(page).to have_link(businesses[2.name])
  end


end
