require 'rails_helper'

RSpec.feature "business admins see links to their businesses on their dashboard" do
  scenario "business admin with multiple businesses views their dashboard" do
    user = create(:user)
    business1 = create(:business, active: true)
    business2 = create(:business, active: true)
    business3 = create(:business, active: true)
    user.businesses << [business1, business2]
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit business_admin_dashboard_path
    within('#site_content') do
      expect(page).to have_link(business1.name)
      expect(page).to have_link(business2.name)

      expect(page).to have_no_content(business3.name)
    end

    click_link(business1.name)
    expect(current_path).to eq(business_dashboard_path(slug: business1.slug))
    within('#site_content') do
      expect(page).to have_content("#{business1.name} Dashboard")
    end
  end
end
