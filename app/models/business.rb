class Business < ActiveRecord::Base
  has_many :business_admins
  has_many :admins, through: :business_admins,
                    class_name: "User",
                    source: "user"
  belongs_to :owner, class_name: "User",
                     foreign_key: "owner_id"


end
