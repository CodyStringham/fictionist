class ChangeContentTypeToInteger < ActiveRecord::Migration
  def up
    remove_column :contents, :asset_type
    add_column :contents, :asset_type, :integer, default: 0
    change_column :users, :role, :integer, default: 0
  end

  def down
    remove_column :contents, :asset_type
    add_column :contents, :asset_type, :string, null: false
    change_column :users, :role, :integer
  end
end
