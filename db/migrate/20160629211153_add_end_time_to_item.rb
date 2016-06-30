class AddEndTimeToItem < ActiveRecord::Migration
  def change
    add_column :items, :end_time, :datetime
  end
end
