require 'rails_helper'

RSpec.describe PredictorService do

  it "calculates final auction time upon initialize" do
    item = create(:item)
    predictor = PredictorService.new(item)
    expect(predictor.final_time.round).to be_within(20).of(86400)
  end

  it "gets new thetas with square root data" do
    time = DateTime.now
    item = create(:item, created_at: time, price: 0)
    bid1 = create(:bid, created_at: time , price: 0, item: item)
    bid1 = create(:bid, created_at: time + 1.second, price: 1, item: item)
    bid2 = create(:bid, created_at: time + 4.second, price: 2, item: item)
    predictor = PredictorService.new(item, 0, 1)
    expect(predictor.get_new_thetas).to eq([0,1])
  end

  it "predicts the final selling price with square root data" do
    time = DateTime.now
    item = create(:item, created_at: time, price: 0, end_time: time + 16.second)
    bid1 = create(:bid, created_at: time , price: 0, item: item)
    bid2 = create(:bid, created_at: time + 1.second, price: 1, item: item)
    bid3 = create(:bid, created_at: time + 4.second, price: 2, item: item)
    predictor = PredictorService.new(item, 0, 1)
    expect(predictor.predict_price).to eq 4
  end

end
