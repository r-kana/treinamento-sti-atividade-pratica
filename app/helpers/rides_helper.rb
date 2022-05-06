module RidesHelper
  def address_format (waypoint)
    "#{waypoint.address}, #{waypoint.neighborhood}"
  end
end
