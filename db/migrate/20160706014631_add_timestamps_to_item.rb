class AddTimestampsToItem < ActiveRecord::Migration
  def change
    add_timestamps :items, null: false 
  end
end
