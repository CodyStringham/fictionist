module PointsHelper

  def get_effort(name)
    Effort.find_by(name: name.split("_").join(" ").titleize).try(:id)
  end

end
