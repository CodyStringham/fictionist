class CreateEfforts < ActiveRecord::Migration
  def change
    create_table :efforts do |t|

      t.string :name
      t.integer :kind
      t.integer :value
      t.timestamps null: false

    end
  end
end
