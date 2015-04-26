module ApplicationHelper
  def place_asset(asset_object, asset_size = 'thumb')
    if asset_object.asset.exists?
      content_type = asset_type(asset_object.asset_content_type)
      asset_check(asset_object, content_type)
    else
      content_tag(:div, content_tag(:h3, asset_object.message, class: 'text'), class: 'item text-div')
    end
  end

  private

  def asset_type(content_type)
    case content_type
    when %r{image} then 'photo'
    when %r{audio|applocation/ogg} then 'music'
    when %r{application/pdf} then 'pdf'
    end
  end

  def asset_check(asset_object, content_type)
    # do more logic here to check if user has unlocked it if it is locked
    asset_status = asset_object.free? ? 'unlocked' : 'locked'
    send("#{asset_status}_#{content_type}", asset_object)
  end

  def locked_photo(asset_object)
    image_tag('photo-thumb-locked.png', alt: asset_object.message, class: 'item music locked')
  end

  def unlocked_photo(asset_object)
    image_tag(asset_object.asset.url(:thumb), alt: asset_object.message, class: 'item image')
  end

  def locked_music(asset_object)
    image_tag('music-thumb-locked.png', alt: asset_object.message, class: 'item music locked')
  end

  def unlocked_music(asset_object)
    link_to asset_object.asset.url, class: 'item music' do
      image_tag('music-thumb.png', alt: asset_object.message, class: 'item music')
    end
  end

  def locked_pdf(asset_object)

  end

  def unlocked_pdf(asset_object)

  end
end

