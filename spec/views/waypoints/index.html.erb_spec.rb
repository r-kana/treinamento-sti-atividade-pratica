require 'rails_helper'

RSpec.describe "waypoints/index", type: :view do
  before(:each) do
    assign(:waypoints, [
      Waypoint.create!(),
      Waypoint.create!()
    ])
  end

  it "renders a list of waypoints" do
    render
  end
end
