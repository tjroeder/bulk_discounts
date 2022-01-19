require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many(:discounts).through(:merchants) }
  end
  
  describe 'validations' do
    it { should define_enum_for(:status).with_values(['in progress', 'cancelled', 'completed']) }
  end
  
  let!(:merch_1) { Merchant.create!(name: 'name_1') }
  let!(:merch_2) { Merchant.create!(name: 'name_2') }

  let!(:disc_1) { create(:discount, threshold: 2, percent: 10, merchant: merch_1) }
  let!(:disc_2) { create(:discount, threshold: 5, percent: 20, merchant: merch_1) }
  let!(:disc_3) { create(:discount, threshold: 10, percent: 50, merchant: merch_1) }
  let!(:disc_4) { create(:discount, threshold: 2, percent: 10, merchant: merch_2) }
  
  let!(:cust_1) { Customer.create!(first_name: 'fn_1', last_name: 'ln_1') }
  let!(:cust_2) { Customer.create!(first_name: 'fn_2', last_name: 'ln_2') }
  let!(:cust_3) { Customer.create!(first_name: 'fn_3', last_name: 'ln_3') }
  let!(:cust_4) { Customer.create!(first_name: 'fn_4', last_name: 'ln_4') }
  let!(:cust_5) { Customer.create!(first_name: 'fn_5', last_name: 'ln_5') }
  let!(:cust_6) { Customer.create!(first_name: 'fn_6', last_name: 'ln_6') }

  let!(:item_1) { Item.create!(name: 'item_1', description: 'desc_1', unit_price: 1, merchant: merch_1) }
  let!(:item_2) { Item.create!(name: 'item_2', description: 'desc_2', unit_price: 2, merchant: merch_1) }
  let!(:item_3) { Item.create!(name: 'item_3', description: 'desc_3', unit_price: 3, merchant: merch_1) }
  let!(:item_4) { Item.create!(name: 'item_4', description: 'desc_4', unit_price: 4, merchant: merch_1) }
  let!(:item_5) { Item.create!(name: 'item_5', description: 'desc_5', unit_price: 5, merchant: merch_1) }
  let!(:item_6) { Item.create!(name: 'item_6', description: 'desc_6', unit_price: 6, merchant: merch_1) }
  let!(:item_7) { Item.create!(name: 'item_7', description: 'desc_7', unit_price: 7, merchant: merch_1) }
  let!(:item_8) { Item.create!(name: 'item_8', description: 'desc_8', unit_price: 8, merchant: merch_1) }
  let!(:item_9) { Item.create!(name: 'item_9', description: 'desc_9', unit_price: 9, merchant: merch_1) }
  let!(:item_10) { Item.create!(name: 'item_10', description: 'desc_10', unit_price: 10, merchant: merch_1) }
  let!(:item_11) { Item.create!(name: 'item_11', description: 'desc_11', unit_price: 11, merchant: merch_2) }
  let!(:item_12) { Item.create!(name: 'item_12', description: 'desc_12', unit_price: 12, merchant: merch_1) }
  let!(:item_13) { Item.create!(name: 'item_13', description: 'desc_13', unit_price: 13, merchant: merch_1) }

  let!(:invoice_1) { create(:invoice, status: 2, customer: cust_1, created_at: DateTime.new(2022, 1, 5, 0 , 0, 0)) }
  let!(:invoice_2) { create(:invoice, status: 2, customer: cust_2, created_at: DateTime.new(2021, 1, 5, 0 , 0, 0)) }
  let!(:invoice_5) { create(:invoice, status: 2, customer: cust_5) }
  let!(:invoice_4) { create(:invoice, status: 2, customer: cust_4) }
  let!(:invoice_3) { create(:invoice, status: 2, customer: cust_3) }
  let!(:invoice_6) { create(:invoice, status: 2, customer: cust_6) }

  let!(:ii_1) { InvoiceItem.create!(item: item_1, invoice: invoice_1, quantity: 1, unit_price: 1, status: 0) }
  let!(:ii_2) { InvoiceItem.create!(item: item_2, invoice: invoice_2, quantity: 2, unit_price: 2, status: 1) }
  let!(:ii_3) { InvoiceItem.create!(item: item_3, invoice: invoice_3, quantity: 3, unit_price: 3, status: 1) }
  let!(:ii_4) { InvoiceItem.create!(item: item_4, invoice: invoice_4, quantity: 3, unit_price: 4, status: 2) }
  let!(:ii_5) { InvoiceItem.create!(item: item_5, invoice: invoice_5, quantity: 3, unit_price: 5, status: 1) }
  let!(:ii_6) { InvoiceItem.create!(item: item_6, invoice: invoice_6, quantity: 3, unit_price: 6, status: 2) }
  let!(:ii_7) { InvoiceItem.create!(item: item_11, invoice: invoice_1, quantity: 3, unit_price: 7, status: 2) }
  let!(:ii_8) { InvoiceItem.create!(item: item_12, invoice: invoice_1, quantity: 4, unit_price: 8, status: 2) }
  let!(:ii_9) { InvoiceItem.create!(item: item_13, invoice: invoice_1, quantity: 5, unit_price: 10, status: 2) }

  let!(:transactions_1) { Transaction.create!(invoice_id: invoice_1.id, credit_card_number: "4654405418240001", credit_card_expiration_date: "0001", result: 2)}
  let!(:transactions_2) { Transaction.create!(invoice_id: invoice_1.id, credit_card_number: "4654405418240002", credit_card_expiration_date: "0002", result: 2)}
  let!(:transactions_3) { Transaction.create!(invoice_id: invoice_2.id, credit_card_number: "4654405418240003", credit_card_expiration_date: "0003", result: 2)}
  let!(:transactions_4) { Transaction.create!(invoice_id: invoice_2.id, credit_card_number: "4654405418240004", credit_card_expiration_date: "0004", result: 2)}
  let!(:transactions_5) { Transaction.create!(invoice_id: invoice_3.id, credit_card_number: "4654405418240005", credit_card_expiration_date: "0005", result: 2)}
  let!(:transactions_6) { Transaction.create!(invoice_id: invoice_3.id, credit_card_number: "4654405418240006", credit_card_expiration_date: "0006", result: 2)}
  let!(:transactions_7) { Transaction.create!(invoice_id: invoice_4.id, credit_card_number: "4654405418240007", credit_card_expiration_date: "0007", result: 2)}
  let!(:transactions_8) { Transaction.create!(invoice_id: invoice_4.id, credit_card_number: "4654405418240008", credit_card_expiration_date: "0008", result: 2)}
  let!(:transactions_9) { Transaction.create!(invoice_id: invoice_5.id, credit_card_number: "4654405418240009", credit_card_expiration_date: "0009", result: 1)}
  let!(:transactions_10) { Transaction.create!(invoice_id: invoice_5.id, credit_card_number: "4654405418240010", credit_card_expiration_date: "0010", result: 1)}
  let!(:transactions_11) { Transaction.create!(invoice_id: invoice_6.id, credit_card_number: "4654405418240011", credit_card_expiration_date: "0011", result: 2)}
  let!(:transactions_12) { Transaction.create!(invoice_id: invoice_6.id, credit_card_number: "4654405418240012", credit_card_expiration_date: "0012", result: 1)}

  describe 'class methods' do
    describe '::incomplete_list' do
      it 'returns a list of pending and packaged invoices' do
        expect(Invoice.incomplete_list.pluck(:id)).to include(invoice_1.id)
        expect(Invoice.incomplete_list.pluck(:id)).to include(invoice_2.id)
        expect(Invoice.incomplete_list.pluck(:id)).to include(invoice_3.id)
        expect(Invoice.incomplete_list.pluck(:id)).to include(invoice_5.id)
      end

      it 'not return shipped invoices' do
        expect(Invoice.incomplete_list).not_to include(invoice_4, invoice_6)
      end
    end

    describe '::order_created_at' do
      it 'returns invoices by created at date' do
        expect(Invoice.order_created_at).to eq([invoice_2, invoice_1, invoice_5, invoice_4, invoice_3, invoice_6])
      end
    end
  end

  describe 'instance methods' do
    describe '#created_at_formatted' do
      it 'returns created_at date formatted' do
        invoice_1 = build(:invoice, created_at: DateTime.new(2022, 1, 5, 0 , 0, 0))

        expect(invoice_1.created_at_formatted).to eq('Wednesday, January 5, 2022')
      end
    end

    describe '#customer_full_name' do
      it 'should return the invoice customers full name' do
        customer_1 = build(:customer, first_name: 'Joe', last_name: 'Dirt')
        invoice_1 = build(:invoice, customer: customer_1)
        expect(invoice_1.customer_full_name).to eq('Joe Dirt')
      end
    end

    describe  '#items_ready_ship' do
      it "returns all the items ready to ship for a merchant" do
        invoice = create(:invoice)
        invoice_items = create_list(:invoice_item, 3, status: 1, invoice: invoice)

        expect(invoice.items_ready_ship).to eq([invoice_items[0], invoice_items[1], invoice_items[2]])
      end
    end
    
    describe '#ii_filtered_by_merch' do
      it 'returns invoice_items filtered by merchants if given' do
        expect(invoice_1.invoice_items).to contain_exactly(ii_1, ii_7, ii_8, ii_9)

        expect(invoice_1.ii_filtered_by_merch(merch_1.id)).to contain_exactly(ii_1, ii_8, ii_9)
      end

      it 'returns invoice_items not filtered by merchants if not given' do
        expect(invoice_1.invoice_items).to contain_exactly(ii_1, ii_7, ii_8, ii_9)

        expect(invoice_1.ii_filtered_by_merch()).to contain_exactly(ii_1, ii_7,ii_8, ii_9)
      end
    end

    describe '#pre_discount_revenue' do
      it 'should return the pre discount revenue for the merchant invoice' do
        merchant_1 = create(:merchant)
        discount_1 = create(:discount, merchant: merchant_1, percent: 20, threshold: 10)
        invoice_1 = create(:invoice)
        items = create_list(:item, 3, merchant: merchant_1)
        invoice_item_1 = create(:invoice_item, item: items[0], invoice: invoice_1, unit_price: 100, quantity: 2)
        invoice_item_2 = create(:invoice_item, item: items[1], invoice: invoice_1, unit_price: 200, quantity: 4)
        invoice_item_3 = create(:invoice_item, item: items[2], invoice: invoice_1, unit_price: 300, quantity: 1)

        expect(invoice_1.pre_discount_revenue(merchant_1)).to eq(1300)
      end
      
      it 'should not return revenue from other items not on the invoice if given merchant' do
        merchant_1 = create(:merchant)
        discount_1 = create(:discount, merchant: merchant_1, percent: 20, threshold: 10)
        invoice_1 = create(:invoice)
        items = create_list(:item, 2, merchant: merchant_1)
        invoice_item_1 = create(:invoice_item, item: items[0], invoice: invoice_1, unit_price: 100, quantity: 3)
        invoice_item_2 = create(:invoice_item, item: items[1], invoice: invoice_1, unit_price: 100, quantity: 7)
        invoice_item_3 = create(:invoice_item, invoice: invoice_1, unit_price: 200, quantity: 2)

        expect(invoice_1.pre_discount_revenue(merchant_1)).to eq(1000)
      end

      it 'should all return revenue for invoice when not given merchant' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        discount_1 = create(:discount, merchant: merchant_1, percent: 20, threshold: 10)
        discount_2 = create(:discount, merchant: merchant_2, percent: 20, threshold: 1)
        invoice_1 = create(:invoice)
        items = create_list(:item, 2, merchant: merchant_1)
        item_3 = create(:item, merchant: merchant_2)
        invoice_item_1 = create(:invoice_item, item: items[0], invoice: invoice_1, unit_price: 100, quantity: 3)
        invoice_item_2 = create(:invoice_item, item: items[1], invoice: invoice_1, unit_price: 100, quantity: 7)
        invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_1, unit_price: 200, quantity: 2)
        
        expect(invoice_1.pre_discount_revenue()).to eq(1400)
      end
    end
    
    describe '#discounted_amount' do
      it 'returns the discounted amount with merchant' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        discount_1 = create(:discount, merchant: merchant_1, percent: 20, threshold: 4)
        discount_2 = create(:discount, merchant: merchant_2, percent: 20, threshold: 1)
        invoice_1 = create(:invoice)
        items = create_list(:item, 2, merchant: merchant_1)
        item_3 = create(:item, merchant: merchant_2)
        invoice_item_1 = create(:invoice_item, item: items[0], invoice: invoice_1, unit_price: 100, quantity: 3)
        invoice_item_2 = create(:invoice_item, item: items[1], invoice: invoice_1, unit_price: 100, quantity: 7)
        invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_1, unit_price: 200, quantity: 2)
 
        example = invoice_1.discounted_amount(merchant_1)[0]['discount_sum'].to_f
        expect(example).to eq(140)
      end
      
      it 'returns the no discounted amount when no discounts with merchant' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        invoice_1 = create(:invoice)
        items = create_list(:item, 2, merchant: merchant_1)
        item_3 = create(:item, merchant: merchant_2)
        invoice_item_1 = create(:invoice_item, item: items[0], invoice: invoice_1, unit_price: 100, quantity: 3)
        invoice_item_2 = create(:invoice_item, item: items[1], invoice: invoice_1, unit_price: 100, quantity: 7)
        invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_1, unit_price: 200, quantity: 2)
        
        example = invoice_1.discounted_amount(merchant_1)[0]['discount_sum'].to_f
        expect(example).to eq(0)
      end
      
      it 'returns the discounted amount with no specified merchant' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        discount_1 = create(:discount, merchant: merchant_1, percent: 20, threshold: 4)
        discount_2 = create(:discount, merchant: merchant_2, percent: 20, threshold: 1)
        invoice_1 = create(:invoice)
        items = create_list(:item, 2, merchant: merchant_1)
        item_3 = create(:item, merchant: merchant_2)
        invoice_item_1 = create(:invoice_item, item: items[0], invoice: invoice_1, unit_price: 100, quantity: 3)
        invoice_item_2 = create(:invoice_item, item: items[1], invoice: invoice_1, unit_price: 100, quantity: 7)
        invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_1, unit_price: 200, quantity: 2)
 
        example = invoice_1.discounted_amount()[0]['discount_sum'].to_f
        expect(example).to eq(220)
      end

      it 'returns the no discounted amount when no discounts with no merchant' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        invoice_1 = create(:invoice)
        items = create_list(:item, 2, merchant: merchant_1)
        item_3 = create(:item, merchant: merchant_2)
        invoice_item_1 = create(:invoice_item, item: items[0], invoice: invoice_1, unit_price: 100, quantity: 3)
        invoice_item_2 = create(:invoice_item, item: items[1], invoice: invoice_1, unit_price: 100, quantity: 7)
        invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_1, unit_price: 200, quantity: 2)
 
        example = invoice_1.discounted_amount()[0]['discount_sum'].to_f
        expect(example).to eq(0)
      end
    end

    describe '#total_discounted_revenue' do
      it 'returns the sum of discounted and non discounted revenue for invoice' do
        expect(invoice_1.total_discounted_revenue()).to eq(88.7)
      end

      it 'returns the sum of discounted and non discounted revenue for merchant invoice' do
        expect(invoice_1.total_discounted_revenue(merch_1.id)).to eq(69.8)
      end

      it 'returns no discounts if quantity is not met for one item' do
        merchant_1 = create(:merchant)
        discount_1 = create(:discount, merchant: merchant_1, percent: 20, threshold: 10)
        items = create_list(:item, 2, merchant: merchant_1)
        example_invoice = create(:invoice)
        invoice_item_1 = create(:invoice_item, quantity: 5, unit_price: 10,item: items[0], invoice: example_invoice) 
        invoice_item_2 = create(:invoice_item, quantity: 5, unit_price: 10, item: items[1], invoice: example_invoice) 
        
        expect(example_invoice.total_discounted_revenue(merchant_1.id)).to eq(100)
      end
      
      it 'returns a discount on one item if it meets the threshold' do
        merchant_1 = create(:merchant)
        discount_1 = create(:discount, merchant: merchant_1, percent: 20, threshold: 10)
        items = create_list(:item, 2, merchant: merchant_1)
        example_invoice = create(:invoice)
        invoice_item_1 = create(:invoice_item, quantity: 10, unit_price: 10,item: items[0], invoice: example_invoice) 
        invoice_item_2 = create(:invoice_item, quantity: 5, unit_price: 10, item: items[1], invoice: example_invoice) 
        
        expect(example_invoice.total_discounted_revenue(merchant_1.id)).to eq(130)
      end
      
      it 'returns different discounts for each item depending on the items quantities' do
        merchant_1 = create(:merchant)
        discount_1 = create(:discount, merchant: merchant_1, percent: 20, threshold: 10)
        discount_2 = create(:discount, merchant: merchant_1, percent: 30, threshold: 15)
        items = create_list(:item, 2, merchant: merchant_1)
        example_invoice = create(:invoice)
        invoice_item_1 = create(:invoice_item, quantity: 12, unit_price: 10,item: items[0], invoice: example_invoice) 
        invoice_item_2 = create(:invoice_item, quantity: 15, unit_price: 10, item: items[1], invoice: example_invoice) 
        
        expect(example_invoice.total_discounted_revenue(merchant_1.id)).to eq(201)
      end

      it 'returns the best discount available' do
        merchant_1 = create(:merchant)
        discount_1 = create(:discount, merchant: merchant_1, percent: 20, threshold: 10)
        discount_2 = create(:discount, merchant: merchant_1, percent: 15, threshold: 15)
        items = create_list(:item, 2, merchant: merchant_1)
        example_invoice = create(:invoice)
        invoice_item_1 = create(:invoice_item, quantity: 12, unit_price: 10,item: items[0], invoice: example_invoice) 
        invoice_item_2 = create(:invoice_item, quantity: 15, unit_price: 10, item: items[1], invoice: example_invoice) 
        
        expect(example_invoice.total_discounted_revenue(merchant_1.id)).to eq(216)
      end
      
      it 'returns discounts for items that are only for the specific merchant' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        discount_1 = create(:discount, merchant: merchant_1, percent: 20, threshold: 10)
        discount_2 = create(:discount, merchant: merchant_1, percent: 30, threshold: 15)
        items = create_list(:item, 2, merchant: merchant_1)
        item_merch_2 = create(:item, merchant: merchant_2)
        example_invoice = create(:invoice)
        invoice_item_1 = create(:invoice_item, quantity: 12, unit_price: 10,item: items[0], invoice: example_invoice) 
        invoice_item_2 = create(:invoice_item, quantity: 15, unit_price: 10, item: items[1], invoice: example_invoice) 
        invoice_item_3 = create(:invoice_item, quantity: 15, unit_price: 10, item: item_merch_2, invoice: example_invoice)

        merch_1_total = example_invoice.total_discounted_revenue(merchant_1.id)
        merch_2_total = example_invoice.total_discounted_revenue(merchant_2.id)
        
        expect(merch_1_total + merch_2_total).to eq(351)
      end
    end
  end
end
