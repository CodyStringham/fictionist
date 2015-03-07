class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :content_type
      t.string :message
      t.string :location
      t.datetime :published_at
      t.integer :view_permission
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :contents, :users
  end
end
