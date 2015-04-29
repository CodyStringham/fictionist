module ApplicationHelper
  def place_asset(asset_object, asset_size = 'thumb')
    if asset_object.asset.exists?
      content_type = asset_type(asset_object.asset_content_type)
      asset_status = asset_check(asset_object)
      send(asset_status, asset_object, content_type, asset_size)
    else
      # i feel like just text does nothing when locked unless they want to lock promo codes or something?
      link_to content_path(asset_object) do
        content_tag(:div, content_tag(:h3, asset_object.message, class: 'text'), class: 'item text-div unlocked')
      end
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

  def asset_check(asset_object)
    # do more logic here to check if user has unlocked it if it is locked
    asset_object.free? ? 'unlocked' : 'locked'
  end

  def unlocked(asset_object, content_type, asset_size)
    # link_to some type of modal to see photos/pdfs and play music / videos with download links
    # link_to asset_object.asset.url, class: "item #{content_type}" do
    link_to content_path(asset_object) do
      image_tag(send("asset_#{content_type}", asset_object, asset_size), alt: asset_object.message, class: "item #{content_type} unlocked")
    end
  end

  def locked(asset_object, content_type, asset_size)
    # link_to some type of modal
    # link_to asset_object.asset.url, class: "item #{content_type}" do
    # image_tag("#{content_type}-thumb-locked.png", alt: asset_object.message, class: "item #{content_type} locked")
    link_to content_path(asset_object) do
      image_tag(send("asset_#{content_type}", asset_object, asset_size), alt: asset_object.message, class: "item #{content_type} locked")
    end
  end

  def asset_photo(asset_object, asset_size)
    asset_object.asset.url(asset_size.to_sym)
  end

  def asset_music(asset_object, asset_size)
    'music-thumb.png'
  end

  def asset_pdf(asset_object, asset_size)

  end
  # def unlocked_music(asset_object, asset_size)
  #   link_to asset_object.asset.url, class: 'item music' do
  #     image_tag('music-thumb.png', alt: asset_object.message, class: 'item music')
  #   end
  # end
end

