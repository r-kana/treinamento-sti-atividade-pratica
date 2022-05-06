require 'rails_helper'

RSpec.describe "waypoints/new", type: :view do
  before(:each) do
    assign(:waypoint, Waypoint.new())
  end

  it "renders new waypoint form" do
    render

    assert_select "form[action=?][method=?]", waypoints_path, "post" do
    end
  end
end
