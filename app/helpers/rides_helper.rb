module RidesHelper
  def address_format(waypoint)
    "#{waypoint.address}, #{waypoint.neighborhood}"
  end

  def full_address_format(waypoint)
    "#{waypoint.address}, #{waypoint.neighborhood}, #{waypoint.city}"
  end
end
