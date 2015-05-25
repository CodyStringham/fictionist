module PointsHelper

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
