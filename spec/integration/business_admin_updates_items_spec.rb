require 'rails_helper'

RSpec.feature "business admin updates items" do
  scenario "from the business dashboard" do
    admin = create(:user)
    business = create(:business)
    item = create(:item, business: business)
    new_name = "Updated Name"
    new_description = "Updated Description"
    # new_price = "Updated Price"
    # new_end_time = Time.now
    admin.businesses << business

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit business_dashboard_path(business.slug)

    click_link "Update"

    expect(current_path).to eq(edit_item_path(item))
    save_and_open_page

    fill_in "item[name]", with: new_name
    fill_in "item[description]", with: new_description
    click_button "Update Item"

    expect(current_path).to eq business_dashboard_path(business)

    within('#flash[success]') do
      expect(page).to have_content("Item ##{item.id} successfully updated!")
    end

    within("#open_auctions") do
      expect(page).to have_content(new_name)
      expect(page).to have_content(new_description)

      expect(page).not_to have_content(item.name)
      expect(page).not_to have_content(item.description)
    end
  end
end
