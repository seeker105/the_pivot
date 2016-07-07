class RemoveOwnerFromBusiness < ActiveRecord::Migration
  def change
    remove_column :businesses, :owner_id, :integer
  end
end
