require 'rails_helper'

RSpec.feature do

  context "guest user permissions" do
    scenario "root path" do
      visit root_url
      within("#main-nav") do
        expect(page).to have_link("Log In")
        expect(page).to have_no_content("Business Admin Dashboard")
        expect(page).to have_no_content("Platform Admin Dashboard")
      end
    end

    scenario "sessions#new path" do
      visit login_path

      within('#login') do
        expect(page).to have_content("Username")
        expect(page).to have_content("Password")
      end
    end
  end

#--------------------------------------

  context "registered user" do
    jmejia = User.create!(username: "jmejia",
                          password: "password",
                          email: "jmejia@turing.io",
                          name: "Josh Mejia",
                          address: Faker::Address.street_address,
                          city: Faker::Address.city,
                          state: Faker::Address.state_abbr,
                          zip: Faker::Address.zip)
    byebug

    scenario "sessions#create path" do
      visit login_path
      user = create(:user)
      byebug
      fill_in "Username", with: user.username
      fill_in "Username", with: 'password'
      click_button "Log In"

      expect(current_path).to eq(dashboard_path)

      within('site_content') do
        expect(page).to have_content('Welcome, Josh Mejia')
      end
    end
  end # of context 'registered user'
end # of test

# scenario "checks for a platform admin" do
#   skip
#
# end
#
# scenario "checks for a business owner" do
#   skip
#   item1 = create(:item, name: "Solid Granite Hipster")
#   item2 = create(:item, name: "Why the duck crossed the road")
#   user = create(:user)
#   # byebug
#   business = Business.create(name: "Freakonomics", owner: user)
#
#   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
#
#   visit items_path(business_id: business.id)
#
#   expect(page).to have_content(item1.name)
#   expect(page).to have_content(item2.name)
# end
#
# scenario "checks for a business admin" do
#   skip
#   item1 = create(:item, name: "Hipchick Granite Hipster")
#   item2 = create(:item, name: "Why the road crossed the duck")
#   bus_owner = create(:user)
#   user = create(:user)
#   business = Business.create(name: "Rubynomics", owner: bus_owner)
#   # byebug
#   business.admins << user
#
#   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
#
#   visit login_path(business_id: business.id)
#
#   within ('#login') do
#     expect(page).to have_content("Username")
#     expect(page).to have_content("Password")
#   end
# end
