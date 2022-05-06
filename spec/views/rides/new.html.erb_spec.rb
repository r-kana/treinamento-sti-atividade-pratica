require 'rails_helper'

RSpec.describe "rides/new", type: :view do
  before(:each) do
    assign(:ride, Ride.new())
  end

  it "renders new ride form" do
    render

    assert_select "form[action=?][method=?]", rides_path, "post" do
    end
  end
end
