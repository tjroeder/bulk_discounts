require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:discounts) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should accept_nested_attributes_for(:discounts) }
  end
  
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  let!(:merch_1) { Merchant.create!(name: 'name_1') }
  let!(:merch_2) { create(:merch_w_all, customer_count: 2) }
  let!(:merch_3) { Merchant.create!(name: 'name_3', status: 'Enabled') }

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
  let!(:item_10) { Item.create!(name: 'item_10', description: 'desc_10', unit_price: 10, status: 'Enabled', merchant: merch_1) }

  let!(:invoice_1) { Invoice.create!(status: 2, created_at:'11 Jan 2022', customer: cust_1) }
  let!(:invoice_2) { Invoice.create!(status: 2, created_at:'12 Jan 2022', customer: cust_2) }
  let!(:invoice_5) { Invoice.create!(status: 2, created_at:'13 Jan 2022', customer: cust_5) }
  let!(:invoice_4) { Invoice.create!(status: 2, created_at:'14 Jan 2022', customer: cust_4) }
  let!(:invoice_3) { Invoice.create!(status: 2, created_at:'15 Jan 2022', customer: cust_3) }
  let!(:invoice_6) { Invoice.create!(status: 2, created_at:'16 Jan 2022', customer: cust_6) }

  let!(:ii_1) { InvoiceItem.create!(item: item_1, invoice: invoice_1, quantity: 1, unit_price: 1, status: 0) }
  let!(:ii_2) { InvoiceItem.create!(item: item_2, invoice: invoice_2, quantity: 2, unit_price: 2, status: 1) }
  let!(:ii_3) { InvoiceItem.create!(item: item_3, invoice: invoice_3, quantity: 3, unit_price: 3, status: 1) }
  let!(:ii_4) { InvoiceItem.create!(item: item_4, invoice: invoice_4, quantity: 3, unit_price: 4, status: 2) }
  let!(:ii_5) { InvoiceItem.create!(item: item_5, invoice: invoice_5, quantity: 3, unit_price: 5, status: 1) }
  let!(:ii_6) { InvoiceItem.create!(item: item_6, invoice: invoice_6, quantity: 3, unit_price: 6, status: 2) }
  # let!(:ii_7) { InvoiceItem.create!(item: item_7, invoice: invoice_7, quantity: 3, unit_price: 7, status: 2) }

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
  # let!(:transactions_13) { Transaction.create!(invoice_id: invoice_7.id, credit_card_number: "4654405418240013", credit_card_expiration_date: "0013", result: 2)}
  # let!(:transactions_14) { Transaction.create!(invoice_id: invoice_7.id, credit_card_number: "4654405418240014", credit_card_expiration_date: "0014", result: 2)}

  describe 'class methods' do
    describe '::top_five_merchants' do
      it 'returns top 5 merchants by revenue' do
        merchants = create_list(:merchant, 6)
        item1 = create(:item, merchant: merchants[0])
        item2 = create(:item, merchant: merchants[1])
        item3 = create(:item, merchant: merchants[2])
        item4 = create(:item, merchant: merchants[3])
        item5 = create(:item, merchant: merchants[4])
        transactions = create_list(:transaction, 5, result: :success)
        invoice_item1 = create(:invoice_item, item: item1, invoice: transactions[0].invoice, unit_price: 300, quantity: 2)
        invoice_item2 = create(:invoice_item, item: item2, invoice: transactions[1].invoice, unit_price: 400, quantity: 2)
        invoice_item3 = create(:invoice_item, item: item3, invoice: transactions[2].invoice, unit_price: 500, quantity: 3)
        invoice_item4 = create(:invoice_item, item: item4, invoice: transactions[3].invoice, unit_price: 600, quantity: 2)
        invoice_item5 = create(:invoice_item, item: item5, invoice: transactions[4].invoice, unit_price: 1000, quantity: 2)
        expected = [merchants[4], merchants[2], merchants[3], merchants[1], merchants[0]]
        
        expect(Merchant.top_five_merchants).to eq(expected)
      end
    end

    describe '::join_trans' do
      it 'returns a join table with Merchant to Items to Invoice Items to Invoices to Transactions' do
        merchants = create_list(:merch_w_all, 2)
        expected = Merchant.joins({invoice_items: {invoice: :transactions}})
        
        expect(Merchant.join_trans).to eq(expected)
      end

      it 'allows reaching from merchant to transactions and count them' do
        expect(Merchant.join_trans.count(:transactions)).to eq(14)
      end
    end
  end
  
  describe 'instance methods' do
    describe 'Merchant Dashboard Statistics' do
      it "shows top 5 customers that have most successful transactions" do
        expected = [cust_1.first_name, cust_2.first_name, cust_3.first_name, cust_4.first_name, cust_6.first_name]
        expect(merch_1.top_customers.pluck(:first_name)).to eq(expected)
      end
    end
  
    describe 'Merchant Dashboard Items Ready to ship' do
      it "shows the item is ready to ship" do
        expected = [item_2.name, item_3.name, item_5.name]
        expect(merch_1.items_ready_ship.pluck(:name)).to eq(expected)
      end
  
      it "checks that the invoices are in order" do
        expected = [invoice_1, invoice_2, invoice_5, invoice_4, invoice_3, invoice_6]
        test = merch_1.order_by_invoice
        expect(test.to_a).to eq(expected)
      end
    end
  
    describe 'Merchant Items Grouped by Status' do
      it 'show disabled_items' do
        expect(merch_1.disabled_items).to eq([item_1, item_2, item_3, item_4, item_5, item_6, item_7, item_8, item_9])
      end
  
      it 'shows enabled items' do
        expect(merch_1.enabled_items).to eq([item_10])
      end
    end
  
    describe 'merchant statuses that are grouped' do
      it "groups merchants by status and shows status" do
        expect(Merchant.disabled_merchants).to eq([merch_1, merch_2])
      end
      it "groups merchants by status and shows status" do
        expect(Merchant.enabled_merchants).to eq([merch_3])
      end
    end
  
    describe 'Merchant Items Index: 5 most popular items' do
      it 'shows top 5 items ranked by most popular/most revenue' do
        expect(merch_1.top_five_items[0]).to eq(item_4)
        expect(merch_1.top_five_items[1]).to eq(item_3)
        expect(merch_1.top_five_items[2]).to eq(item_6)
        expect(merch_1.top_five_items[3]).to eq(item_2)
        expect(merch_1.top_five_items[4]).to eq(item_1)
      end
    end
  
    it "shows date of highest revenue for each merchant" do
      merchant = Merchant.create!(name: 'name_3')
  
      customer1 = Customer.create!(first_name: 'wade', last_name: 'wade')
      customer2 = Customer.create!(first_name: 'edaw', last_name: 'edaw')
  
      item1 = Item.create!(name: 'item_8', description: 'desc_8', unit_price: 8, merchant: merchant)
      item2 = Item.create!(name: 'item_9', description: 'desc_9', unit_price: 9, merchant: merchant)
  
      invoice1 = Invoice.create!(status: 2, created_at:'15 Jan 2022', customer: customer1)
      invoice2 = Invoice.create!(status: 2, created_at:'16 Jan 2022', customer: customer2)
  
      ii1 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 3, unit_price: 5, status: 2)
      ii2 = InvoiceItem.create!(item: item2, invoice: invoice2, quantity: 3, unit_price: 6, status: 2)
  
  
      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: "4654405418240011", credit_card_expiration_date: "0011", result: 2)
      transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: "4654405418240012", credit_card_expiration_date: "0012", result: 2)
  
      expect(merch_1.best_sale.created_at).to eq(invoice_4.created_at)
      expect(merchant.best_sale.created_at).to eq(invoice2.created_at)
    end
  end
end
