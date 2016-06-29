require "rails_helper"

RSpec.feature "The Item class closes the correct auctions" do
  scenario "it closes the auctions that are ending currently" do
    item1 = create(:item, status:  0, end_time: DateTime.now.at_beginning_of_day)
    item2 = create(:item, status:  0, end_time: DateTime.now.at_beginning_of_day + 24.hour)

    # Item.where(status: 0).each do |item|
    #   if item.end_time <= DateTime.now
    #     puts "Should be 1"
    #     item.update_attribute(:status, 1)
    #   end
    # end

    Item.update_status

    byebug

    # puts "item " + x.to_s
    # puts item.end_time
    # puts DateTime.now
    # puts item.end_time <= DateTime.now
    #   #close auction
    #   if (item.bids.count > 0)
    #     item.update_attribute('status', 0)
    #     #notify winnner
    #   else
    #     item.update_attribute('status', 1)
    #   end
  end





end
