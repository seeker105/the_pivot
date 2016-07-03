require 'rails_helper'

RSpec.feature "business admin can update business info" do
  scenario "they fill in the form with updated business info" do
    user = create(:user)
    business = create(:business)
    business_admin = BusinessAdmin.create(user_id: user, business_id: business)
    admin = user.business_admins.first

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    updated_business_name = "New Name"
    updated_business_description = "New Description"

    # visit business_admin_dashboard_path
    # click_link business.name
    # expect(path).to eq business_path(business)
    visit business_path(business)
    click_link "Update Business Information"
    fill_in "business[name]", with: updated_business_name
    fill_in "business[description]", with: updated_business_description
    click_button "Update"

    expect(current_path).to eq business_path(business)

    within("#flash_success") do
      expect(page).to have_content("Successfully updated business information!")
    end

    within("Some html") do
      expect(page).to have_content(updated_business_name)
      expect(page).to have_content(updated_business_description)

      expect(page).not_to have_content(business.name)
      expect(page).not_to have_content(business.description)
    end
  end
end
