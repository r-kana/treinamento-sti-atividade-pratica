require 'rails_helper'

RSpec.describe "waypoints/edit", type: :view do
  before(:each) do
    @waypoint = assign(:waypoint, Waypoint.create!())
  end

  it "renders the edit waypoint form" do
    render

    assert_select "form[action=?][method=?]", waypoint_path(@waypoint), "post" do
    end
  end
end
