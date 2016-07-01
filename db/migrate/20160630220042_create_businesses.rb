class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.boolean :active, default: false
      t.string :slug
      t.integer :owner_id, index: true

      t.timestamps null: false
    end
    add_foreign_key :businesses, :users, column: :owner_id
  end
end
