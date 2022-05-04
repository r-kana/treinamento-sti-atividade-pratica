require 'rails_helper'

RSpec.describe "waypoints/show", type: :view do
  before(:each) do
    @waypoint = assign(:waypoint, Waypoint.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
