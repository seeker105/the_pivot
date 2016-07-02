class CreateBusinessAdmins < ActiveRecord::Migration
  def change
    create_table :business_admins do |t|
      t.references :business, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
