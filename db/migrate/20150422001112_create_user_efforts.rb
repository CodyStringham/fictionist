class CreateUserEfforts < ActiveRecord::Migration
  def change
    create_table :user_efforts do |t|
      t.integer :status, default: 0
      t.integer :value
      t.attachment :screenshot

      t.references :user, index: true
      t.references :effort, index: true

      t.timestamps null: false
    end
    add_foreign_key :user_efforts, :users
    add_foreign_key :user_efforts, :efforts
  end
end
