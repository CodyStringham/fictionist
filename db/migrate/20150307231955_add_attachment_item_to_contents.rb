class AddAttachmentItemToContents < ActiveRecord::Migration
  def self.up
    change_table :contents do |t|
      t.attachment :item
    end
  end

  def self.down
    remove_attachment :contents, :item
  end
end
