class AddRequestedVenueToUser < ActiveRecord::Migration
  def change
    add_column :users, :requested_venue, :string
  end
end
