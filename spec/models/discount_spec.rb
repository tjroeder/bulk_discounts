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
end
