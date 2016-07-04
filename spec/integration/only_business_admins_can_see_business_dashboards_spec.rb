require 'rails_helper'

RSpec.feature "only business admins can see business dashboards" do
  scenario "logged in business admin visits the dashboard" do
    # happy path:
    # as a logged in business admin
    admin_user = create(:user)
    business = create(:business, active: true)
    admin_user.businesses << business

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)

    # I visit the business dashboard path for my business
    # I see the business header on the page
    visit business_dashboard_path(slug: business.slug)

    expect(page).to have_content("#{business.name} Dashboard")
  end

  scenario "logged in non-admin user visits business dashboard path" do
    # sad path 1:
    # a logged in user
    # I visit the dashboard path for a business
    # I see a 404 error
    user = create(:user)
    business = create(:business)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit business_dashboard_path(slug: business.slug)
    within('title') do
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end
  end

  scenario "logged in business admin visits the dashboard path for a business he is NOT admin of" do
    # sad path 2:
    # as a logged in business admin,
    admin_user = create(:user)
    business = create(:business, active: true)
    admin_user.businesses << business

    other_business = create(:business, active: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)

    # I visit the dashboard path for a business that I am NOT the admin of
    # I see a 404 error
    visit business_dashboard_path(slug: other_business.slug)
    within('title') do
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end
  end
end
