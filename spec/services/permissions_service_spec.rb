require 'rails_helper'

RSpec.feature do
  scenario "checks for a platform admin" do
    item = create(:item)
    user = create(:user, platform_admin: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit item_path(item.id)

    expect(page).to have_content(item.name)
    expect(page).to have_content(item.description)
  end

  scenario "checks for a business owner" do
    item1 = create(:item, name: "Solid Granite Hipster")
    item2 = create(:item, name: "Why the duck crossed the road")
    user = create(:user)
    # byebug
    business = Business.create(name: "Freakonomics", owner: user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit items_path(business_id: business.id)

    expect(page).to have_content(item1.name)
    expect(page).to have_content(item2.name)
  end
end
