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
end
