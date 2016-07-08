module ApplicationHelper
  def format_bidder(high_bidder)
    if high_bidder
      high_bidder.username
    else
      "None"
    end
  end

  def predict_price(item)
    if item.bids.count >= 3
      predictor = PredictorService.new(item)
      "$#{predictor.predict_price.round(2)}"
    else
      "Not enough bids yet to make prediction"
    end
  end
end
