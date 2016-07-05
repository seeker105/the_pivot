require "rails_helper"

RSpec.feature "Authenticated User has correct privledges" do
  scenario "cannot view another user's data" do
    users = create_list(:user, 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(users[0])

    visit dashboard_path

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content(users[0].username)
    expect(page).to_not have_content(users[1].username)

    expect{visit ("/users/#{users[1].id}") }.to raise_error( ActionController::RoutingError)
  end

  scenario "cannot view admin dashboard" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit business_admin_dashboard_path

    expect(page).to have_content("The page you were looking for doesn't exist.")
  end

end
