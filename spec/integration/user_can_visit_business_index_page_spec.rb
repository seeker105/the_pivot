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
    save_and_open_page
    expect(current_path).to eq(businesses_path)
    expect(page).to have_link(businesses[0].name)
    expect(page).to have_link(businesses[1].name)
    expect(page).to have_link(businesses[2].name)
  end

  scenario "user clicks on a link to be taken to a business show page" do
    businesses = create_list(:business, 3)
    
    visit businesses_path

    click_link(businesses[0].name)
    expect(current_path).to eq(business_path(id: businesses[0].id))
    expect(page).to have_content(business[0].name)
    expect(page).to have_content(business[0].name)
    expect(page).to have_content(business[0].name)
    expect(page).to have_content(business[0].name)
  end

end
