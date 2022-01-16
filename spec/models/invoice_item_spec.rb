require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
  end

  describe 'validations' do
    it {should validate_presence_of :quantity}
    it {should validate_presence_of :unit_price}
    it { should define_enum_for(:status).with_values(['pending', 'packaged', 'shipped']) }
  end

  describe 'instance methods' do
    describe '#total_revenue' do
      it 'returns quantity multiplied by unit price' do
        invoice_items = create_list(:invoice_item, 3, quantity: 2, unit_price: 100)
  
        expect(InvoiceItem.total_revenue).to eq(600)
      end
    end
  end
end
