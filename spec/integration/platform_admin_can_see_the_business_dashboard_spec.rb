require 'rails_helper'

RSpec.feature "business dashboard permission" do
  scenario "A platform admin can see a business' dashboard" do

    admin = create(:user, platform_admin: true)
    my_business = create(:business, active: true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit business_dashboard_path(my_business.slug)

    expect(current_path).to eq("/#{my_business.slug}/dashboard")
    within(".business_header") do
      expect(page).to have_content("#{my_business.name} Dashboard")
    end
  end


  scenario "A platform admin can see all businesses' dashboard" do

    admin = create(:user, platform_admin: true)
    user1 = create(:user)
    user1.businesses << business1 = create(:business, active: true)
    user2 = create(:user)
    user2.businesses << business2 = create(:business, active: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit business_dashboard_path(business1.slug)

    expect(current_path).to eq("/#{business1.slug}/dashboard")
    within(".business_header") do
      expect(page).to have_content("#{business1.name} Dashboard")
    end

    visit business_dashboard_path(business2.slug)

    expect(current_path).to eq("/#{business2.slug}/dashboard")
    within(".business_header") do
      expect(page).to have_content("#{business2.name} Dashboard")
    end
  end

end
