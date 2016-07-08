require 'rails_helper'

RSpec.describe Business, type: :model do

  let(:inactive_business) { build(:business) }
  let(:active_business) { build(:business, active: true) }
  let(:persistant_business) { create(:business, active: true, name: "My Fantastic #%&* business") }
  let(:business_with_items) { create(:business_with_items) }
  let(:business_with_items) { create(:business_with_items) }

  describe "attributes" do
    it { expect(inactive_business).to respond_to(:name) }
    it { expect(inactive_business).to respond_to(:active) }
    it { expect(inactive_business).to respond_to(:description) }
    it { expect(inactive_business).to respond_to(:slug) }
    it { expect(inactive_business).to respond_to(:business_admins) }
    it { expect(inactive_business).to respond_to(:admins) }
    it { expect(inactive_business).to respond_to(:items) }
    it { expect(active_business).to respond_to(:items) }
  end

  describe "associations" do
    it { expect(inactive_business).to have_many(:business_admins) }
    it { expect(inactive_business).to have_many(:admins) }
    it { expect(inactive_business).to have_many(:items) }
  end

  it "generates the slug before creation" do
    expect(inactive_business.slug).to be_nil
    expect(persistant_business.slug).to_not be_nil
    expect(persistant_business.slug).to eq("my-fantastic-business")
   end

  it "knows its open items" do
   expect(business_with_items.open_items.count).to eq 3
  end

  it "knows its closed items" do
    item = business_with_items.items.first
    item.update(status: 1)
    expect(business_with_items.closed_items.count).to eq 1
  end

  it "can create an active business" do
    expect(active_business.active?).to be true
  end
end
