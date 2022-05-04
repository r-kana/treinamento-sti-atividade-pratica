require 'rails_helper'

RSpec.describe "rides/edit", type: :view do
  before(:each) do
    @ride = assign(:ride, Ride.create!())
  end

  it "renders the edit ride form" do
    render

    assert_select "form[action=?][method=?]", ride_path(@ride), "post" do
    end
  end
end
