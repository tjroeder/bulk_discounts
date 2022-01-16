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

  describe 'class methods' do
    describe '::total_revenue' do
      it 'returns quantity multiplied by unit price for each invoice item' do
        invoice_item_1 = create(:invoice_item, quantity: 4, unit_price: 500)
        invoice_items = create_list(:invoice_item, 2, quantity: 2, unit_price: 100)
        invoice_item_2 = create(:invoice_item, quantity: 5, unit_price: 200)
        examples = InvoiceItem.total_revenue.order(revenue: :desc)

        expect(examples[0].revenue).to eq(2000)
        expect(examples[1].revenue).to eq(1000)
        expect(examples[2].revenue).to eq(200)
        expect(examples[3].revenue).to eq(200)
      end
    end
  end
end
