class AddBusinessIdToItems < ActiveRecord::Migration
  def change
    add_reference :items, :business, index: true, foreign_key: true
  end
end
