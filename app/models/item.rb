class Item < ActiveRecord::Base
  has_many :categories_items
  has_many :categories, through: :categories_items
  has_many :bids
  belongs_to :business

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true

  enum status: ["open", "closed"]

  def high_bid
    high_bid = bids.maximum('price')
    high_bid ? high_bid : 0.00
  end

  def high_bidder
    self.bids.exists? ? self.bids.find_by(price: high_bid).user : nil
  end

  def self.update_status
    where(status: 0).where("end_time < ?", DateTime.now).update_all(status: 1)
  end

end
