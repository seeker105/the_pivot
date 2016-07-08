class AddImagePathToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :image_path, :text
  end
end
