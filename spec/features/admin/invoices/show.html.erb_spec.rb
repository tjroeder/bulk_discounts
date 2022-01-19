require 'rails_helper'

RSpec.describe 'admin invoices index dashboard page', type: :feature do
  let!(:merch_1) { Merchant.create!(name: 'name_1') }
  let!(:merch_2) { Merchant.create!(name: 'name_2') }

  let!(:discount_1) { create(:discount, merchant: merch_1) }
  let!(:discount_2) { create(:discount, merchant: merch_1) }
  let!(:discount_3) { create(:discount, merchant: merch_2) }
  let!(:discount_4) { create(:discount, merchant: merch_2) }

  let!(:cust_1) { Customer.create!(first_name: 'fn_1', last_name: 'ln_1') }
  let!(:cust_2) { Customer.create!(first_name: 'fn_2', last_name: 'ln_2') }

  let!(:item_1) { Item.create!(name: 'item_1', description: 'desc_1', unit_price: 1, merchant: merch_1) }
  let!(:item_2) { Item.create!(name: 'item_2', description: 'desc_2', unit_price: 2, merchant: merch_1) }
  let!(:item_3) { Item.create!(name: 'item_3', description: 'desc_3', unit_price: 3, merchant: merch_1) }
  let!(:item_4) { Item.create!(name: 'item_4', description: 'desc_4', unit_price: 4, merchant: merch_1) }

  let!(:invoice_1) { Invoice.create!(status: 2, customer: cust_1) }
  let!(:invoice_2) { Invoice.create!(status: 2, customer: cust_2) }

  let!(:ii_1) { InvoiceItem.create!(item: item_1, invoice: invoice_1, quantity: 1, unit_price: 1, status: 0) }
  let!(:ii_2) { InvoiceItem.create!(item: item_2, invoice: invoice_1, quantity: 2, unit_price: 2, status: 1) }
  let!(:ii_3) { InvoiceItem.create!(item: item_3, invoice: invoice_1, quantity: 2, unit_price: 2, status: 1) }
  let!(:ii_4) { InvoiceItem.create!(item: item_4, invoice: invoice_2, quantity: 2, unit_price: 2, status: 1) }

  before :each do
    visit "/admin/invoices/#{invoice_1.id}"
  end

  it "checks that the invoice id shows" do
    expect(page).to have_content("Invoice - #{invoice_1.id}")
  end

  it "checks that the invoice status shows" do
    expect(page).to have_content("Status: #{invoice_1.status}")
  end

  it "checks invoice created date/time" do
    expect(page).to have_content("Created on: #{invoice_1.created_at_formatted}")
  end

  it "shows the customers name" do
    expect(page).to have_content("Customer: #{invoice_1.customer.full_name}")
  end

  it "list all the items" do
    expect(page).to have_content("Items:")
    expect(page).to have_content(invoice_1.items.first.name)
    expect(page).to have_content(invoice_1.items[1].name)
    expect(page).to have_content(invoice_1.items.last.name)
  end

  it "shows the quanity per item" do
    expect(page).to have_content(invoice_1.invoice_items.first.quantity)
  end

  it "shows the unit_price sold per item" do
    expect(page).to have_content(invoice_1.invoice_items.first.unit_price)
  end

  it "shows the status per item" do
    expect(page).to have_content(invoice_1.status)
  end

  it "shows the total revenue of the invoice" do
    rev = invoice_1.pre_discount_revenue()
    expected = h.number_to_currency(rev.fdiv(100))

    expect(page).to have_content("Total Revenue: #{expected}")
  end

  it "shows the total discounted revenue of the invoice" do
    rev = invoice_1.pre_discount_revenue()
    expected = h.number_to_currency(rev.fdiv(100))

    expect(page).to have_content("Total Discounted Revenue: #{expected}")
  end

  it "checks that the status is being updated" do
    expect(page).to have_content(invoice_1.status)
    expect(page).to have_select('invoice_status', options: ['in progress', 'cancelled', 'completed'], selected: 'completed')
  end

  it "status changes once a new status if selected " do
    select('in progress', from: 'invoice_status')
    click_button('Update Invoice Status')

    expect(page).to have_select('invoice_status', selected: 'in progress')
  end
end
