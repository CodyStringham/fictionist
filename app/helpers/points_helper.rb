module PointsHelper

  def get_effort(name)
    Effort.find_by(name: name.split("_").join(" ").titleize).try(:id)
  end

  def user_has_effort?(effort_id)
    current_user.user_efforts.any? {|user_effort| user_effort.effort_id == effort_id }
  end

  def find_effort(effort_id)
    current_user.user_efforts.where(effort_id: effort_id).order( 'created_at DESC' ).first
  end

end
