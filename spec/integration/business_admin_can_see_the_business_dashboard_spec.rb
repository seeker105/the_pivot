require 'rails_helper'

RSpec.feature "business dashboard permission" do
  scenario "A business admin can see their business' dashboard" do

    admin = create(:user)
    admin.businesses << create(:business)
    my_business = admin.businesses.first
    allow_any_instance_of(ApplicationController).to receive(:current_user).
      and_return(admin)

    visit business_dashboard_path(my_business.slug)

    expect(current_path).to eq("/#{my_business.slug}/dashboard")

    within(".business_header") do
      expect(page).to have_content("#{my_business.name} Dashboard")
    end

  end

  scenario "A business admin cannot see another business's dashboard" do

    admin = create(:user)
    my_business = admin.businesses << create(:business)

    allow_any_instance_of(ApplicationController).to receive(:current_user).
      and_return(admin)

    other_business = create(:business)

    visit business_dashboard_path(other_business.slug)
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

  scenario "A regular user cannot see a business's dashboard" do
    user = create(:user)
    business = create(:business)

    allow_any_instance_of(ApplicationController).to receive(:current_user).
      and_return(user)

    visit business_admin_dashboard_path(business.slug)
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

end
