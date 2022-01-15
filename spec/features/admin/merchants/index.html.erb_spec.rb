require 'rails_helper'

RSpec.describe 'admin merchants index dashboard page', type: :feature do
  context 'as an admin' do
    describe 'name of every merchant' do
      it 'displays header for admin dashboard' do
        merch_1 = Merchant.create!(name: 'name_1')
        merch_2 = Merchant.create!(name: 'name_2')
        visit admin_merchants_path

        expect(page).to have_content(merch_1.name)
        expect(page).to have_content(merch_2.name)
      end
    end

    describe 'link to admin merchant show page' do
      it "links to the admin merchant show page" do
        merch_1 = Merchant.create!(name: 'name_1')
        merch_2 = Merchant.create!(name: 'name_2')
        visit admin_merchants_path

        click_link "#{merch_1.name}"
        expect(current_path).to eq(admin_merchant_path(merch_1))
      end
    end

    describe 'Link to create a new merchant' do
      it "links to new page to create new merchant" do
        merch_1 = Merchant.create!(name: 'name_1')
        merch_2 = Merchant.create!(name: 'name_2')
        visit admin_merchants_path

        expect(page).to have_link("Create New Merchant")
        click_link "Create New Merchant"
        expect(current_path).to eq(new_admin_merchant_path)
      end
    end

    describe 'enable and disable of merchants' do
      it "enables or disbales merchants depending on status" do
        merch_1 = Merchant.create!(name: 'name_1')
        merch_2 = Merchant.create!(name: 'name_2')
        visit admin_merchants_path

        expect(merch_1.status).to eq('Disabled')
        click_button "Enable #{merch_1.name}"
        expect('Enabled Merchants').to appear_before(merch_1.name)
        expect('Disabled Merchants').to_not appear_before(merch_1.name)
        click_button "Disable #{merch_1.name}"
        expect('Disabled Merchants').to appear_before(merch_1.name)
      end
    end

    describe 'top 5 merchants by revenue' do
      it "shows the top 5 merchants by revenue" do
        merchants = create_list(:merchant, 6)
        item1 = create(:item, merchant: merchants[0])
        item2 = create(:item, merchant: merchants[1])
        item3 = create(:item, merchant: merchants[2])
        item4 = create(:item, merchant: merchants[3])
        item5 = create(:item, merchant: merchants[4])
        transactions = create_list(:transaction, 5, result: :success)
        invoice_item1 = create(:invoice_item, item: item1, invoice: transactions[0].invoice, unit_price: 3, quantity: 2)
        invoice_item2 = create(:invoice_item, item: item2, invoice: transactions[1].invoice, unit_price: 4, quantity: 2)
        invoice_item3 = create(:invoice_item, item: item3, invoice: transactions[2].invoice, unit_price: 5, quantity: 2)
        invoice_item4 = create(:invoice_item, item: item4, invoice: transactions[3].invoice, unit_price: 6, quantity: 2)
        invoice_item5 = create(:invoice_item, item: item5, invoice: transactions[4].invoice, unit_price: 1, quantity: 2)
        blahblah = [merchants[3], merchants[2], merchants[1], merchants[0], merchants[4]]
        visit admin_merchants_path

        expect(page).to have_content("Top 5 Merchant by Total Revenue")
        expect(page).to have_content(merchants[0].name)
        expect(page).to have_content(merchants[1].name)
        expect(page).to have_content(merchants[3].name)
        expect(page).to have_content(merchants[4].name)
      end

      it "shows date of best revenue day" do
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
        visit admin_merchants_path

        expect(page).to have_content('Sunday, January 16, 2022')
        expect(page).to_not have_content('Saturday, January 15, 2022')
      end
    end
  end
end
