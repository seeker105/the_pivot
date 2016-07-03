require 'rails_helper'

RSpec.feature "authorize the updating of business information" do
  scenario "a business admin can see a link to update business information" do
    admin = create(:user)
    business = create(:business)
    business_admin = BusinessAdmin.create(user: admin, business: business)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit business_path(business.slug)
    expect(page).to have_link("Update Business Information")
  end

  scenario "a non-admin user cannot update business information" do
    admin = create(:user)
    business = create(:business)
    business_admin = BusinessAdmin.create(user: admin, business: business)

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit business_path(business.slug)

    expect(page).not_to have_content("Update Business Information")
  end



end
