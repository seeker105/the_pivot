require 'rails_helper'

RSpec.feature "business admin can see their businesses" do
  scenario "on their admin dashboard" do
    admin = create(:user)
    businesses = create_list(:business, 3)
    business_admin1 = BusinessAdmin.create(user_id: admin, business_id: businesses[0].id)
    business_admin2 = BusinessAdmin.create(user_id: admin, business_id: businesses[1].id)
    business_admin3 = BusinessAdmin.create(user_id: admin, business_id: businesses[2].id)
    other_business = create(:business)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit business_admin_dashboard_path

    within("some html") do
      expect(page).to have_link(businesses[0].name)
      expect(page).to have_link(businesses[1].name)
      expect(page).to have_link(businesses[2].name)
    end

    expect(page).not_to have_link(other_business.name)

  end
end
