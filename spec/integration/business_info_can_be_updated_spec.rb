require 'rails_helper'

RSpec.feature "business info can be updated" do
  scenario "fill in form with updated business info" do
    business = create(:business)
    updated_business_name = "New Name"
    updated_business_description = "New Description"

    visit business_path(business.slug)
    click_link "Update Business Information"
    fill_in "business[name]", with: updated_business_name
    fill_in "business[description]", with: updated_business_description
    click_button "Update"

    expect(current_path).to eq business_path(business.slug)
    within("#flash_success") do
      expect(page).to have_content("Successfully updated business information!")
    end

    within(".business_info") do
      expect(page).to have_content(updated_business_name)
      expect(page).to have_content(updated_business_description)
      expect(page).not_to have_content(business.name)
      expect(page).not_to have_content(business.description)
    end
  end
end
