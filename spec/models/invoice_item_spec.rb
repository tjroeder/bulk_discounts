require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
    it { should have_one(:merchant).through(:item) }
    it { should have_many(:discounts).through(:merchant) }
  end

  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :item_id }
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

    describe '::not_shipped' do
      it 'returns invoice items which are not shipped' do
        invoice_item_1 = create(:invoice_item, :pending)
        invoice_item_2 = create(:invoice_item, :shipped)
        invoice_item_3 = create(:invoice_item, :packaged)
        invoice_item_4 = create(:invoice_item, :pending)

        expect(InvoiceItem.not_shipped).to contain_exactly(invoice_item_1, invoice_item_3, invoice_item_4)
        expect(InvoiceItem.not_shipped).not_to contain_exactly(invoice_item_2)
      end
    end
  end

  describe 'instance methods' do
    describe '#best_discount' do
      it 'returns true when invoice item is past discount threshold' do
        merchant_1 = create(:merchant)
        discount_1 = create(:discount, threshold: 5, merchant: merchant_1)
        item_1 = create(:item, merchant: merchant_1)
        invoice_item_1 = create(:invoice_item, item: item_1, quantity: 6)
        
        expect(invoice_item_1.best_discount).to eq(discount_1)
      end

      it 'returns true if there are multiple discounts available' do
        merchant_1 = create(:merchant)
        discount_1 = create(:discount, threshold: 5, merchant: merchant_1)
        discount_2 = create(:discount, threshold: 2, merchant: merchant_1)
        discount_3 = create(:discount, threshold: 10, merchant: merchant_1)
        item_1 = create(:item, merchant: merchant_1)
        invoice_item_1 = create(:invoice_item, item: item_1, quantity: 6)
        
        expect(invoice_item_1.best_discount).to eq(discount_2)
      end
      
      it 'returns the best discount if multiple are available' do
        merchant_1 = create(:merchant)
        discount_1 = create(:discount, percent: 50, threshold: 5, merchant: merchant_1)
        discount_2 = create(:discount, percent: 77, threshold: 2, merchant: merchant_1)
        discount_3 = create(:discount, percent: 88, threshold: 10, merchant: merchant_1)
        item_1 = create(:item, merchant: merchant_1)
        invoice_item_1 = create(:invoice_item, item: item_1, quantity: 6)
        
        expect(invoice_item_1.best_discount).to eq(discount_2)
      end
      
      it 'returns false if there are no discounts that meet threshold' do
        merchant_1 = create(:merchant)
        discount_1 = create(:discount, threshold: 5, merchant: merchant_1)
        discount_2 = create(:discount, threshold: 2, merchant: merchant_1)
        discount_3 = create(:discount, threshold: 10, merchant: merchant_1)
        item_1 = create(:item, merchant: merchant_1)
        invoice_item_1 = create(:invoice_item, item: item_1, quantity: 1)
        
        expect(invoice_item_1.best_discount).to eq(nil)
      end
    end
    
    describe '#revenue_calc' do
      it 'returns the revenue calculation' do
        invoice_item_1 = create(:invoice_item, quantity: 2, unit_price: 33)
        
        expect(invoice_item_1.revenue_calc).to eq(66)
      end
    end
    
    describe '#line_item_revenue' do
      it 'returns the revenue without discounts' do
        invoice_item_1 = create(:invoice_item, quantity: 2, unit_price: 33)
        
        expect(invoice_item_1.line_item_revenue).to eq(66)
      end
      
      it 'returns the revenue with a discount' do
        merchant_1 = create(:merchant)
        discount_1 = create(:discount, threshold: 2, percent: 10, merchant: merchant_1)
        item_1 = create(:item, merchant: merchant_1)
        invoice_item_1 = create(:invoice_item, item: item_1, quantity: 2, unit_price: 33)
        
        expect(invoice_item_1.line_item_revenue).to eq(59.4)
      end
      
      it 'returns revenue with the best discount' do
        merchant_1 = create(:merchant)
        discount_1 = create(:discount, threshold: 5, percent: 20, merchant: merchant_1)
        discount_2 = create(:discount, threshold: 2, percent: 10, merchant: merchant_1)
        discount_3 = create(:discount, threshold: 10, merchant: merchant_1)
        item_1 = create(:item, merchant: merchant_1)
        invoice_item_1 = create(:invoice_item, item: item_1, quantity: 6, unit_price: 33)

        expect(invoice_item_1.line_item_revenue).to eq(158.4)
      end
    end
  end
end
