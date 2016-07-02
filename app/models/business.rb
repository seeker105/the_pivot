class Business < ActiveRecord::Base
  has_many :business_admins
  has_many :admins, through: :business_admins,
                    class_name: "User",
                    source: "user"
  belongs_to :owner, class_name: "User",
                     foreign_key: "owner_id"
  has_many :items

  before_save :create_slug

private
  def create_slug
    self.slug = self.name.parameterize
  end

end
