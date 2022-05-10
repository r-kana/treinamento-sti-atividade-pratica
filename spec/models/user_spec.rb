require 'rails_helper'
let!(:user) {create(:user)}

RSpec.describe User, type: :model do
  it "#active?" do
    expect(user.active?).to be(true)
  end
  it '#active_rides' do
    create_list(:ride, 5, driver: user, college_id: college.id)
    expect(user.active_rides.length).to be(5)
  end
  it '#admin?' do
    user = create(:user, :is_admin)
    expect(user.admin?).to be(true)
  end
  context 'when creating' do
    it 'should be valid with valid params' do
      expect(user.valid?).to be(true)
    end
    it "should be invalid with unformated cpf" do
      user = create(:user, cpf: '11.111.1-111')
      expect(user.valid?).to be(false)
    end
    it 'should be invalid without params' do
      user = User.new
      expect(user.valid?).to be(false)
      expect(user.errors.any?).to be(true)
    end
  end
end
