module CollegeHelper
  def full_address college
    "#{college.address}, #{college.neighborhood}, #{college.city}"
  end
end
