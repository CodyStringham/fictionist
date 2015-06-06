class AddDescToEfforts < ActiveRecord::Migration
  def change
    add_column :efforts, :desc, :string
  end
end
