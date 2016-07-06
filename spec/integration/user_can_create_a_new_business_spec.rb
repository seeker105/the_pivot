require "rails_helper"

RSpec.feature "Business can be created" do
  scenario "by a registered user" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).
      and_return(user)

    visit dashboard_path

    expect(page).to have_link("Create New Business")
    click_link "Create New Business"

    fill_in "business[name]", with: "Cubby Stuffers"
    fill_in "business[description]",
             with: "A vertically integrated subscription snack service"

    click_button "Create Business"

    new_business = Business.last

    expect(new_business.admins.include?(user)).to be true

    visit business_path(new_business.slug)
  end
end
