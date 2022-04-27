require 'rails_helper'

RSpec.describe "campus/index", type: :view do
  before(:each) do
    assign(:campus, [
      Campu.create!(),
      Campu.create!()
    ])
  end

  it "renders a list of campus" do
    render
  end
end
