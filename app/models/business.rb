class Business < ActiveRecord::Base
  has_many :business_admins
  has_many :admins, through: :business_admins,
                    class_name: "User",
                    source: "user"
  has_many :items

  before_create :create_slug

  def open_items
    self.items.where(status: 0)
  end

  def closed_items
    self.items.where(status: 1)
  end

  def status
    self.active ? "Active" : "Inactive"
  end

private
  def create_slug
    self.slug = self.name.parameterize
  end

end
