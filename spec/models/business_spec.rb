require 'rails_helper'

RSpec.describe Business, type: :model do
  context "relationships" do
    it {should have_many(:items)}
  end

  scenario "it creates the slug" do
    business = create(:business, name: "My Fantastic! @$#%*! Business!")

    assert_equal "my-fantastic-business", business.slug
  end
end
