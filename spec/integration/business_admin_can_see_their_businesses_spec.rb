require 'rails_helper'

RSpec.feature "business admin can see their businesses" do
  scenario "on their admin dashboard" do
    admin = create(:user)
    businesses = create_list(:business, 3)
    business_admin1 = BusinessAdmin.create(user: admin, business: businesses[0])
    business_admin2 = BusinessAdmin.create(user: admin, business: businesses[1])
    business_admin3 = BusinessAdmin.create(user: admin, business: businesses[2])
    other_business = create(:business)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit business_admin_dashboard_path

    within("h1") do
      expect(page).to have_content("Business Admin Dashboard")
    end

    within(".business_list") do
      expect(page).to have_link(businesses[0].name)
      expect(page).to have_link(businesses[1].name)
      expect(page).to have_link(businesses[2].name)
    end

    expect(page).not_to have_link(other_business.name)

  end

  scenario "store owner can see the admins for their business" do
    owner = create(:user)
    businesses = create_list(:business, 3, owner: owner)
    admin1 = create(:user)
    admin2 = create(:user)
    admin3 = create(:user)

    business_admin1 = BusinessAdmin.create(user: admin1, business: businesses[0])
    business_admin2 = BusinessAdmin.create(user: admin2, business: businesses[0])
    business_admin3 = BusinessAdmin.create(user: admin3, business: businesses[0])

    allow_any_instance_of(ApplicationControler).to receive(:current_user).and_return(owner)

    visit business_admin_dashboard_path

    click_link(businesses[0].name)

    


  end
end