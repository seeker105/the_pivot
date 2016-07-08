class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  validates :user, presence: :true
  validates :item, presence: :true
  validates :price, presence: :true

  validates_uniqueness_of :price,
                          scope: [:user_id, :item_id],
                          allow_nil: true
end
