class User < ActiveRecord::Base
  has_many :orders
  has_many :bids
  has_many :items, through: :bids
  has_many :business_admins
  has_many :businesses, through: :business_admins

  validates :username, presence: :true, uniqueness: :true
  validates :password, presence: :true
  validates :email, presence: :true
  validates :name, presence: :true
  validates :address, presence: :true
  validates :city, presence: :true
  validates :state, presence: :true
  validates :zip, presence: :true

  has_secure_password validations: false
  validates_confirmation_of :password, message: "does not match"
  validates_confirmation_of :email, message: "does not match"


  enum role:["default", "admin"]

  def to_param
  end

  def open_items
    self.items.where(status: "open")
  end

  def platform_admin?
    self.platform_admin
  end


end
