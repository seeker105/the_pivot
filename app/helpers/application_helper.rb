module ApplicationHelper
  def format_bidder(high_bidder)
    if high_bidder
      high_bidder.username
    else
      "None"
    end
  end

  def order_items_by_id(items)
    items.order(:id)
  end
end
