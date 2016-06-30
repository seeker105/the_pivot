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
end
