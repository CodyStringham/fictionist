module ApplicationHelper
  def place_asset(asset_object, asset_size = 'thumb')
    if asset_object.asset.exists?
      # REGEX fun
      # ["image/jpeg", "image/png", "image/jpg", "image/gif", "application/pdf", "audio/ogg", "applocation/ogg", "audio/mpeg", "audio/mp3"]
      if asset_object.asset_content_type =~ %r{image}
        image_tag(asset_object.asset.url(:thumb), alt: asset_object.message, class: 'item image')
      elsif asset_object.asset_content_type =~ %r{audio|applocation/ogg}
        link_to asset_object.asset.url, class: 'item music' do
          image_tag('music-thumb.png', alt: asset_object.message, class: 'item music')
        end
      elsif asset_object.asset_content_type =~ %r{application/pdf}
      end
    else
      content_tag(:div, content_tag(:h3, asset_object.message, class: 'text'), class: 'item text-div')
      # assume it is a text message and display some type of block with text?
    end
  end
end

