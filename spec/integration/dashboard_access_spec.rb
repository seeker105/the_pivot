require 'rails_helper'

RSpec.feature "dashboard access" do

  scenario "as a default user" do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    within("#main-nav") do
      expect(page).to have_link("Logged in as #{user.username}")
      expect(page).not_to have_link("Admin Dashboard")
    end

    click_link "Logged in as #{user.username}"

    within("#user-dashboard") do
      expect(page).to have_content("Welcome, #{user.name}")
      expect(page).to have_link("Update Personal Account Information")
      expect(page).to have_link("Create A New Business")
    end
  end

  scenario "as a business admin" do
    admin = create(:user)
    business = create(:business)
    other_business = create(:business)
    admin.businesses << business

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit root_path

    within("#main-nav") do
      expect(page).to have_link("Logged in as #{admin.username}")
      expect(page).to have_link("Admin Dashboard")
    end
    save_and_open_page

    click_link "Admin Dashboard"

    save_and_open_page

    within(".business_list")
    expect(page).to have_content(business.name)
    expect(page).not_to have_content(other_business.name)
  end
end
