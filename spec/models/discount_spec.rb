require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:items).through(:merchant) }
    it { should have_many(:invoice_items).through(:items) }
  end
  
  describe 'validations' do
    it { should validate_presence_of :percent }
    it { should validate_presence_of :threshold }
    it do 
      should validate_numericality_of(:percent).is_greater_than(0).is_less_than(100).only_integer
    end
    it do
      should validate_numericality_of(:threshold).is_greater_than(0).only_integer
    end
  end

  describe 'factory bot' do
    it 'creates valid discount objects' do
      example = build(:discount)
      expect(example).to be_a(Discount)
    end

    it 'creates valid attributes' do
      example = build(:discount, percent: 20, threshold: 7)
      expect(example).to have_attributes(percent: 20)
      expect(example).to have_attributes(threshold: 7)
    end

    it 'will create discounts that are between 1-99 percent off' do
      FactoryBot.rewind_sequences
      example = build_list(:discount, 101)

      expect(example[0].percent).to eq(1)
      expect(example[99].percent).to eq(1)
    end
  end
end
