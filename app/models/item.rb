class Item < ActiveRecord::Base
  has_many :categories_items
  has_many :categories, through: :categories_items
  has_many :order_items
  has_many :bids

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true

  enum status: ["active", "retired"]

  def quantity(order_id)
    order_item = self.order_items.find_by(order_id: order_id)
    order_item.quantity
  end

  def subtotal(order_id)
    order_item = self.order_items.find_by(order_id: order_id)
    order_item.subtotal
  end

  def high_bid
    high_bid = bids.maximum('price')
    high_bid ? high_bid : 0.00
  end

  def high_bidder
    Bid.count > 0 ? Bid.find_by(price: high_bid).user : nil
  end
end
