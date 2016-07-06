require 'rails_helper'

RSpec.feature "business admin can see their businesses" do

  scenario "store owner can see the admins for their business" do
    skip "Owner function not yet implemented"
    owner = create(:user)
    businesses = create_list(:business, 3, owner: owner)
    admin1 = create(:user)
    admin2 = create(:user)
    admin3 = create(:user)

    business_admin1 = BusinessAdmin.create(user: admin1, business: businesses[0])
    business_admin2 = BusinessAdmin.create(user: admin2, business: businesses[0])
    business_admin3 = BusinessAdmin.create(user: admin3, business: businesses[0])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(owner)

    visit business_admin_dashboard_path

    click_link(businesses[0].name)
    expect(current_path).to eq(business_admin_dashboard_path)

    within(".admin_header") do
      expect(page).to have_content("Business Admin Dashboard")
    end
  end
end
