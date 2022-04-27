require 'rails_helper'

RSpec.describe "campus/show", type: :view do
  before(:each) do
    @campu = assign(:campu, Campu.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
