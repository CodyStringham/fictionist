class AddUploaderIdToContents < ActiveRecord::Migration
  def up
    add_column :contents, :uploader_id, :integer
    add_column :contents, :value, :integer, default: 0
    add_column :redemptions, :value, :integer, default: 0
    remove_column :contents, :user_id
  end

  def down
    remove_column :contents, :uploader_id
    remove_column :contents, :value
    remove_column :redemptions, :value
    add_column :contents, :user_id, :integer
  end
end
