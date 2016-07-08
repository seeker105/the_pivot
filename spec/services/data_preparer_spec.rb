require 'rails_helper'

RSpec.describe DataPreparer do
  it "finds the output for one bid" do
    user = create(:user)
    item = create(:item)
    bid = Bid.create(price: 10, item: item, user: user )
    item.bids << bid
    preparer = DataPreparer.new(item)
    expect(preparer.outputs).to eq [bid.price]
  end

  it "finds the input for one bid" do
    time = DateTime.now
    user = create(:user)
    item = create(:item, created_at: time)
    bid = Bid.create(price: 10, item: item, user: user , created_at: time)
    preparer = DataPreparer.new(item)
    expect(preparer.inputs).to eq [0]
  end

  it "formats one input and output pair correctly as training data" do
    time = DateTime.now
    user = create(:user)
    item = create(:item, created_at: time)
    bid = Bid.create(price: 10, item: item, user: user, created_at: time)
    preparer = DataPreparer.new(item)

    training_data = [{i: 0, o: 10}]
    expect(preparer.format_training_data).to eq training_data
  end

  it "formats many input and output pairs correctly" do
    time = DateTime.now
    user = create(:user)
    item = create(:item, created_at: time)
    bid1 = Bid.create(price: 10, item: item, user: user, created_at: time)
    bid2 = Bid.create(price: 11, item: item, user: user, created_at: time)
    bid3 = Bid.create(price: 12, item: item, user: user, created_at: time)
    preparer = DataPreparer.new(item)

    training_data = [{i: 0, o: 10}, {i: 0, o: 11}, {i: 0, o: 12}]
    expect(preparer.format_training_data).to eq training_data
  end
end
