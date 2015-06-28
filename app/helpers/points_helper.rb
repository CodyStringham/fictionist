module PointsHelper

  def social_text(effort)
    case effort.kind
    when "facebook_like" then "Facebook Like"
    when "facebook_post" then "Facebook Post"

    when "twitter_like" then "Twitter Follow"
    when "twitter_post" then "Twitter Tweet"

    when "instagram_like" then "Instagram Follow"
    when "instagram_post" then "Instagram Post"

    when "youtube_like" then "Youtube Subscribe"
    when "youtube_post" then "Youtube Video"
    end
  end


  def get_effort(name)
    Effort.find_by(name: name.split("_").join(" ").titleize).try(:id)
  end

  def user_has_effort?(effort_id)
    current_user.user_efforts.any? {|user_effort| user_effort.effort_id == effort_id && !user_effort.declined? }
  end

  def find_effort(effort_id)
    current_user.user_efforts.where(effort_id: effort_id).order( 'created_at DESC' ).first
  end

  def effort_available?(effort)
    effort.completed_at && effort.completed_at <= Time.now - 7.days
  end

  def effort_cooldown?(effort)
    effort.completed_at && effort.completed_at >= Time.now - 7.days
  end

  def cooldown_time(effort)
    resets_at = effort.completed_at.to_date + 7.days
    days = resets_at - Time.now.to_date
    days.to_i
  end

end
