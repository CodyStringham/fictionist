class CreateRedemptions < ActiveRecord::Migration
  def up
    create_table :redemptions do |t|
      t.references :user, index: true
      t.references :content, index: true

      t.timestamps null: false
    end
    add_column :users, :points, :integer, default: 0
    add_foreign_key :redemptions, :users
    add_foreign_key :redemptions, :contents
  end

  def down
    drop_table :redemptions
    remove_column :users, :points
  end
end
