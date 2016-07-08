module ApplicationHelper
  def format_bidder(high_bidder)
    if high_bidder
      high_bidder.username
    else
      "None"
    end
  end

  def capitalize(name)
    name.capitalize
  end

  def predict_price(item)
    if item.bids.count >= 3
      predictor = PredictorService.new(item)
      determine_result(predictor)   
    else
      "Not enough bids yet to make prediction"
    end
  end

  def determine_result(predictor)
    if predictor.predict_price
      "$#{predictor.predict_price.round(2)}"
    else
      "Unable to make prediction"
    end
  end

  def order_items_by_id(items)
    items.order(:id)
  end
end
