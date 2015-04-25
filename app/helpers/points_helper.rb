module PointsHelper

  def get_effort(name)
    Effort.find_by(kind: name).id
  end

end
