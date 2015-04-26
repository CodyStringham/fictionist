class AddRepeatableToEfforts < ActiveRecord::Migration
  def change
    add_column :efforts, :repeatable, :boolean
  end
end
