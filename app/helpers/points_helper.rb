module PointsHelper

  def get_effort(name)
    Effort.find_by(name: name.split("_").join(" ").titleize).id
  end

end
