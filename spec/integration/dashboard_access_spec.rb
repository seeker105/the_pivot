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

    click_link "Admin Dashboard"

    within(".business_list") do
      expect(page).to have_content(business.name)
      expect(page).not_to have_content(other_business.name)
    end
  end

  scenario "as a platform admin" do
    admin = create(:user, platform_admin: true)
    business1 = create(:business)
    business2 = create(:business)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit root_path

    within("#main-nav") do
      expect(page).to have_link("Logged in as #{admin.username}")
      expect(page).to have_link("Admin Dashboard")
    end

    click_link "Admin Dashboard"
    expect(current_path).to eq platform_admin_dashboard_path

    within("##{business1.slug}") do
      expect(page).to have_content(business1.name)
    end

    within("##{business2.slug}") do
      expect(page).to have_content(business2.name)
    end
  end
end
