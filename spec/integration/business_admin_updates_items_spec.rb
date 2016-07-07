require 'rails_helper'

RSpec.feature "business admin updates items" do
  scenario "from the business dashboard" do
    admin = create(:user)
    business = create(:business, active: true)
    item = create(:item, business: business)
    new_name = "Updated Name"
    new_description = "Updated Description"

    admin.businesses << business

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit business_dashboard_path(business.slug)
    click_link "Update"
    visit edit_business_item_path(business.slug, item)

    fill_in "item[name]", with: new_name
    fill_in "item[description]", with: new_description
    click_button "Update Item"

    expect(current_path).to eq business_dashboard_path(business.slug)

    within('#flash_success') do
      expect(page).to have_content("Item ##{item.id} successfully updated!")
    end

    within("#open_auction") do
      expect(page).to have_content(new_name)

      expect(page).not_to have_content(item.name)
    end
  end

  scenario "default user cannot edit items" do
    business = create(:business, active: true )
    item = create(:item, business: business)
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit edit_business_item_path(business.slug, item)

    expect(page).to have_content("The page you were looking for doesn't exist")
  end

  scenario "admins can only edit items that belong to their business" do
    not_my_item = create(:item)
    admin = create(:user)
    business = create(:business, active: true)
    admin.businesses << business
    not_my_business = create(:business, active: true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit edit_business_item_path(not_my_business.slug, not_my_item)
    expect(page).to have_content("The page you were looking for doesn't exist")
  end
end
