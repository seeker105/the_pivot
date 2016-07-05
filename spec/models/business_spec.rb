require 'rails_helper'

RSpec.describe Business, type: :model do
  context "relationships" do
    it {should have_many(:items)}
  end

  scenario "it creates the slug" do
    business = create(:business, name: "My Fantastic! @$#%*! Business!")

    assert_equal "my-fantastic-business", business.slug
  end

  scenario "it knows its open items" do
    business = create(:business)
    business.items << create_list(:item, 3)

    expect(business.open_items.count).to eq 3
  end

  scenario "it knows its closed items" do
    business = create(:business)
    business.items << create(:item, status: "closed")

    expect(business.closed_items.count).to eq 1
  end
end
