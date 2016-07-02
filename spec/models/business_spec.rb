require 'rails_helper'

RSpec.describe Business, type: :model do
  context "relationships" do
    it {should have_many(:items)}
  end
end
