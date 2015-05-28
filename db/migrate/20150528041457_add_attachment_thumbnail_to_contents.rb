class AddAttachmentThumbnailToContents < ActiveRecord::Migration
  def self.up
    change_table :contents do |t|
      t.attachment :thumbnail
    end
  end

  def self.down
    remove_attachment :contents, :thumbnail
  end
end
