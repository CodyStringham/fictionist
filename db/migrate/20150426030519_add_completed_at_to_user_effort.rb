class AddCompletedAtToUserEffort < ActiveRecord::Migration
  def change
    add_column :user_efforts, :completed_at, :datetime
  end
end
