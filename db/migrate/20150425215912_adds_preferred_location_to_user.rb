class AddsPreferredLocationToUser < ActiveRecord::Migration
  def change
    add_column :users, :preferred_location, :integer
  end
end
