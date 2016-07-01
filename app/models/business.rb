class Business < ActiveRecord::Base
  has_many :business_admins
  has_many :users, through: :business_admins
  belongs_to :owner, class_name: "User",
                     foreign_key: "owner_id"


end
