require 'rails_helper'

RSpec.describe PredictorService do

  it "calculates final auction time upon initialze" do
    item = create(:item)
    predictor = PredictorService.new(item)
    expect(predictor.final_time.round).to eq 86400
  end
 #it takes in data from data preparer
 #give this data to the reduce_cost method of the learner
 # the result will be a new theta0 and theta1
 #instantiate a new hypoth obj with the new thetas
 #call the function method with item end time - item.created at as the add_foreign_key

 #will want this object to return the result of the function => predicted price
 #for an item



end
