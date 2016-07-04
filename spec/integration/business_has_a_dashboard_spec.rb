require 'rails_helper'

RSpec.feature "business has a dashboard" do
  scenario "anyone visits the dashboard" do

    business = create(:business)

    visit business_dashboard_path(business.slug)

    within(".business_header") do
      expect(page).to have_content("#{business.name} Dashboard") 
    end
    
  end
end
