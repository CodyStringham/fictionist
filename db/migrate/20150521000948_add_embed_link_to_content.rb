class AddEmbedLinkToContent < ActiveRecord::Migration
  def change
    add_column :contents, :embed_link, :string
  end
end
