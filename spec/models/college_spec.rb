require 'rails_helper'

RSpec.describe College, type: :model do
  context 'when creating a new instance' do
    it 'is valid with the correct values' do
      college = build(:college)
      expect(college.valid?).to be(true)
    end
    it 'is invalid without name' do
      college = build(:college, name: nil)
      expect(college.valid?).to be(false)
    end
    it 'is invalid without phone_number' do
      college = build(:college, phone_number: nil)
      expect(college.valid?).to be(false)
    end
    it 'is invalid without address' do
      college = build(:college, address: nil)
      expect(college.valid?).to be(false)
    end
    it 'is invalid without city' do
      college = build(:college, city: nil)
      expect(college.valid?).to be(false)
    end
    it 'is invalid without neighborhood' do
      college = build(:college, neighborhood: nil)
      expect(college.valid?).to be(false)
    end
    it 'is invalid without cep' do
      college = build(:college, cep: nil)
      expect(college.valid?).to be(false)
    end
    it 'should be active by default' do
      college = build(:college)
      expect(college.active).to be(true)
    end
    it 'is valid with 9 char cep' do
      college = build(:college)
      expect(college.cep.length).to eq(9)
      expect(college.valid?).to be(true)
    end
    it 'is valid with 10 char cep' do
      college = build(:college, cep: "0000000000")
      expect(college.cep.length).to eq(10)
      expect(college.valid?).to be(false)
    end
    it 'is invalid with 8 char cep' do
      college = build(:college, cep: "00000000")
      expect(college.cep.length).to eq(8)
      expect(college.valid?).to be(false)
    end
    it 'is invalid with unformatted phone_number' do
      college = build(:college, phone_number: "552199999999")
      expect(college.valid?).to be(false)
    end
    it 'is valid with formatted phone_number' do
      college = build(:college, phone_number: "219999-9999")
      expect(college.valid?).to be(true)
    end
  end
end
