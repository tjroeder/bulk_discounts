require 'rails_helper'

RSpec.describe 'merchant dashboard page', type: :feature do
  let!(:merch_1) { Merchant.create!(name: 'name_1') }

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


  let!(:invoice_1) { Invoice.create!(status: 2, customer: cust_1) }
  sleep(0.01)
  let!(:invoice_2) { Invoice.create!(status: 2, customer: cust_2) }
  let!(:invoice_5) { Invoice.create!(status: 2, customer: cust_5) }
  let!(:invoice_4) { Invoice.create!(status: 2, customer: cust_4) }
  let!(:invoice_3) { Invoice.create!(status: 2, customer: cust_3) }
  let!(:invoice_6) { Invoice.create!(status: 2, customer: cust_6) }


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

  before(:each) { visit merchant_dashboard_index_path(merch_1) }
  
  context 'as a merchant' do
    describe 'view elements' do
      it 'displays the merchants name' do
        expect(page).to have_content(merch_1.name)
      end
      
      it "shows the name of top 5 customers who have conducted the largest number of succesful transactions" do
        expect(page).to have_content("Top Five Customers:")
        expect(cust_1.first_name).to appear_before(cust_2.first_name)
        expect(cust_2.first_name).to appear_before(cust_3.first_name)
        expect(cust_3.first_name).to appear_before(cust_6.first_name)
        expect(cust_6.first_name).to_not appear_before(cust_2.first_name)
      end
      
      it "shows the count of succesful transactions for the top 5 customers" do
        expect(page).to have_content("Count of Transactions:")
        expect("Count of Transactions: 2").to appear_before("Count of Transactions: 1")
        expect(page).to have_content(1)
        expect(page).to have_content(2)
      end

      it "shows the items ready to be shipped for each customer" do
        expect(page).to have_content('Items Packaged and Ready to Ship:')
        expect(page).to have_content(item_2.name)
        expect(page).to have_content(item_3.name)
        expect(page).to have_content(item_5.name)
      end
    
      it "shows the items invoice ids" do
        expect(page).to have_content("Invoice id# #{item_2.invoices.ids.first}" )
        expect(page).to have_content("Invoice id# #{item_3.invoices.ids.first}")
        expect(page).to have_content("Invoice id# #{item_5.invoices.ids.first}")
      end

      it "shows the items in order of invoice tiem created" do
        expect(item_2.name).to appear_before(item_5.name)
        expect(item_5.name).to appear_before(item_3.name)
      end
    end

    describe 'clickable page elements' do
      it "displays link that redirects to merchant item index " do
        expect(page).to have_link("Merchant Items")
        
        click_link "Merchant Items"
        
        expect(current_path).to eq(merchant_items_path(merch_1))
      end

      it "displays link that redirects to merchant invoices index" do
        expect(page).to have_link("Merchant Invoices")
        
        click_link "Merchant Invoices"

        expect(current_path).to eq(merchant_invoices_path(merch_1))
      end

      it "has a link on invoice id that redirects to the invoice show page" do
        click_link "#{item_2.invoices.ids.first}"
        
        expect(current_path).to eq("/merchants/#{merch_1.id}/invoices/#{item_2.invoices.ids.first}")
      end
    end
  end
end
