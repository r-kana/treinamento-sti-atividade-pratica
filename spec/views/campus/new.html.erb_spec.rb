require 'rails_helper'

RSpec.describe "campus/new", type: :view do
  before(:each) do
    assign(:campu, Campu.new())
  end

  it "renders new campu form" do
    render

    assert_select "form[action=?][method=?]", campus_path, "post" do
    end
  end
end
