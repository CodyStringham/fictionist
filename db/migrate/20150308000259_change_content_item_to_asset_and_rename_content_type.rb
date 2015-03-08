class ChangeContentItemToAssetAndRenameContentType < ActiveRecord::Migration
  def up
    remove_attachment :contents, :item
    add_attachment :contents, :asset
    rename_column :contents, :content_type, :asset_type
  end

  def down
    remove_attachment :contents, :asset
    add_attachment :contents, :item
    rename_column :contents, :asset_type, :content_type
  end
end
