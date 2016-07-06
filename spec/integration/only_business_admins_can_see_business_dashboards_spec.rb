require 'rails_helper'

RSpec.feature "only business admins can see business dashboards" do
  scenario "logged in business admin visits the dashboard" do
    admin_user = create(:user)
    business = create(:business, active: true)
    admin_user.businesses << business

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)

    visit business_dashboard_path(slug: business.slug)
    within('body') do
      expect(page).to have_content("#{business.name} Dashboard")
    end
  end

  scenario "logged in non-admin user visits business dashboard path" do
    user = create(:user)
    business = create(:business)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit business_dashboard_path(slug: business.slug)
    within('title') do
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end
  end

  scenario "logged in business admin visits the dashboard path for a business he is NOT admin of" do
    admin_user = create(:user)
    business = create(:business, active: true)
    admin_user.businesses << business

    other_business = create(:business, active: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)

    visit business_dashboard_path(slug: other_business.slug)
    within('title') do
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end
  end
end
