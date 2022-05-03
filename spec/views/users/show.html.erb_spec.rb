require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      email: "Email",
      password_digest: "Password Digest",
      name: "Name",
      iduff: "Iduff",
      cpf: "Cpf"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Password Digest/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Iduff/)
    expect(rendered).to match(/Cpf/)
  end
end
