require 'rails_helper'

RSpec.feature "user can see the homepage for various businesses" do
  scenario "they see only the items for that business" do
    business1 = create(:business_with_items)
    items1 = business1.items
    business2 = create(:business_with_items)
    items2 = business2.items

    visit business_path(business1.slug)
    expect(current_path).to eq("/business-a")

    within("h1") do
      expect(page).to have_content(business1.name)
    end

    within("#business-items") do
      expect(page).to have_content(items1[0].name)
      expect(page).to have_content(items1[1].name)
      expect(page).not_to have_content(items2[0].name)
      expect(page).not_to have_content(items2[1].name)
    end

    visit business_path(business2.slug)
    expect(current_path).to eq("/business-b")

    within("h1") do
      expect(page).to have_content(business2.name)
    end
    
    within("#business-items") do
      expect(page).to have_content(items2[0].name)
      expect(page).to have_content(items2[1].name)
      expect(page).not_to have_content(items1[0].name)
      expect(page).not_to have_content(items1[1].name)
    end

  end
end
