require 'rails_helper'

RSpec.describe "rides/index", type: :view do
  before(:each) do
    assign(:rides, [
      Ride.create!(),
      Ride.create!()
    ])
  end

  it "renders a list of rides" do
    render
  end
end
