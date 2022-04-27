require 'rails_helper'

RSpec.describe "campus/edit", type: :view do
  before(:each) do
    @campu = assign(:campu, Campu.create!())
  end

  it "renders the edit campu form" do
    render

    assert_select "form[action=?][method=?]", campu_path(@campu), "post" do
    end
  end
end
