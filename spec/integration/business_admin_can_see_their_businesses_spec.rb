require 'rails_helper'

RSpec.feature "business admin can see their businesses" do
  scenario "on their admin dashboard" do
    admin = create(:user)
    businesses = admin.businesses << create_list(:business, 3)
    other_business = create(:business)

    allow_any_instance_of(ApplicationController).to receive(:current_user).
      and_return(admin)

    visit business_admin_dashboard_path

    expect(current_path).to eq(business_admin_dashboard_path)
    
    within(".admin_header") do
      expect(page).to have_content("Business Admin Dashboard")
    end

    within(".business_list") do
      expect(page).to have_link(businesses[0].name)
      expect(page).to have_link(businesses[1].name)
      expect(page).to have_link(businesses[2].name)
    end

    expect(page).not_to have_link(other_business.name)

  end
end
