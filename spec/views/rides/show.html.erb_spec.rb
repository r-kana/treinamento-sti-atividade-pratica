require 'rails_helper'

RSpec.describe "rides/show", type: :view do
  before(:each) do
    @ride = assign(:ride, Ride.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
