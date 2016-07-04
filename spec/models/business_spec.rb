require 'rails_helper'

RSpec.describe Business, type: :model do
  context "relationships" do
    it { should have_many(:items) }
    it { should belong_to(:owner) }
  end

  scenario "it creates the slug" do
    business = create(:business, name: "My Fantastic! @$#%*! Business!")

    assert_equal "my-fantastic-business", business.slug
  end
end
