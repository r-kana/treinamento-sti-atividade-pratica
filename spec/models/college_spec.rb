require 'rails_helper'

RSpec.describe College, type: :model do
  context 'when creating a new instance' do
    it 'is valid with the correct values' do
      college = build(:college)
      expect(college.valid?).to be(true)
    end
    it 'is invalid without name' do
    end
    it 'is invalid without phone_number' do
    end
    it 'is invalid without address' do
    end
    it 'is invalid without city' do
    end
    it 'is invalid without neighborhood' do
    end
    it 'is invalid without cep' do
    end
    it 'should be active by default' do
    end
    it 'is valid with 9 char cep' do
    end
    it 'is valid with 10 char cep' do
    end
    it 'is invalid with 8 char cep' do
    end
    it 'is invalid with unformatted phone_number' do
    end
  end
end
