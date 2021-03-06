class Item < ActiveRecord::Base
  has_many :categories_items
  has_many :categories, through: :categories_items
  has_many :bids
  belongs_to :business

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true

  enum status: ["open", "closed"]

  def has_bids?
    bids.exists?
  end

  def high_bid
    high_bid = bids.maximum('price')
    high_bid ? high_bid : 0.00
  end

  def high_bidder
    self.bids.exists? ? self.bids.find_by(price: high_bid).user : nil
  end

  def max_price
    high_bid > self.price ? high_bid : self.price
  end

  def min_bid
    high_bid == 0.0 ? self.price : high_bid + 1.0
  end

  def self.update_status
    where(status: 0).where("end_time < ?", DateTime.now).update_all(status: 1)
  end

  def self.active
    joins(:business).where(businesses: {active: true})
  end

  def update_own_status
    if self.end_time < DateTime.now 
      self.update_attributes(status: 1)
    end
  end
end
