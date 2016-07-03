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

  scenario "an admin cannot updated info for businesses that are not theirs" do
    admin1 = create(:user)
    business1 = create(:business)
    business_admin1 = BusinessAdmin.create(user: admin1, business: business1)

    admin2 = create(:user)
    business2 = create(:business)
    business_admin2 = BusinessAdmin.create(user: admin2, business: business2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin1)

    visit business_path(business2.slug)

    expect(page).not_to have_content("Update Business Information")
  end



end
