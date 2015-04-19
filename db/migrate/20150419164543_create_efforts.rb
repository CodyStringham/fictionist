class CreateEfforts < ActiveRecord::Migration
  def change
    create_table :efforts do |t|
      t.integer :kind
      t.integer :value
      t.integer :status
      t.attachment :proof

      t.references :user, index: true
      t.timestamps null: false
    end
    add_foreign_key :efforts, :users
  end
end
