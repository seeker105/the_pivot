require "rails_helper"

RSpec.feature "Unauthenticated User has correct privledges" do
  scenario "cannot view another user's data" do
    user = create(:user)

    visit dashboard_path

    within("title") do
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end
  end

  scenario "cannot view admin dashboard" do
    visit business_admin_dashboard_path

    expect(current_path).to eq(business_admin_dashboard_path)
    within("title") do
      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end
  end
end
