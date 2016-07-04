require 'rails_helper'

RSpec.feature "business dashboard shows item info" do
  scenario "for a business with no items" do
    business = create(:business)

    visit business_dashboard_path(business.slug)

    within(".business_items") do
      expect(page).to have_content("There are no items for this business yet")
    end
  end

end
