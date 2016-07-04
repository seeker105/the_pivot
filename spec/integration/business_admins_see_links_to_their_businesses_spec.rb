require 'rails_helper'

RSpec.feature "business admins see links to their businesses on their dashboard" do
  scenario "business admin with multiple businesses views their dashboard" do
    #     as a logged in business admin with 2 businesses
    user = create(:user)
    business1 = create(:business, active: true)
    business2 = create(:business, active: true)
    business3 = create(:business, active: true)
    user.businesses << [business1, business2]
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    # I visit the business admin dashboard path
    visit business_admin_dashboard_path
    within('#site_content') do
      # I see links to the names of businesses that I am an admin of
      expect(page).to have_link(business1.name)
      expect(page).to have_link(business2.name)

      # I do not see links to any businesses that i am not an admin for
      expect(page).to have_no_content(business3.name)
    end

    # I click the links and see that I reach the dashboards for those businesses
    click_link(business1.name)
    expect(current_path).to eq(business_dashboard_path(slug: business1.slug))
    within('#site_content') do
      expect(page).to have_content("#{business1.name} Dashboard")
    end
  end
end
