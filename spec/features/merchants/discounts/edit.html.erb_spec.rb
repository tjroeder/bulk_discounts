require 'rails_helper'

RSpec.describe 'merchants/discounts/edit.html.erb', type: :feature do
  let!(:merch_1) { create(:merchant) }
  let!(:disc_1) { create(:discount, merchant: merch_1, percent: 17, threshold: 42) }

  before(:each) { visit edit_merchant_discount_path(merch_1, disc_1) }

  context 'as a merchant' do
    describe 'viewable page elements' do
      it 'displays submit, and number fields with original percent, and threshold values' do
        expect(page).to have_field('discount_percent', type: 'number', with: 17)
        expect(page).to have_field('discount_threshold', type: 'number', with: 42)
        expect(page).to have_button('Save Discount')
      end
    end

    describe 'editting merchant discount with form' do
      it 'can edit discount and display on merchant discounts index' do
        fill_in 'discount_percent', with: 77
        fill_in 'discount_threshold', with: 33
        click_button 'Save Discount'

        expect(page).to have_current_path(merchant_discounts_path(merch_1))
        expect(page).to have_content('77% off 33 or more items')
      end

      it 'redirects back to edit discount if given invalid data' do
        fill_in 'discount_percent', with: 101
        fill_in 'discount_threshold', with: 0
        click_button 'Save Discount'

        expect(page).to have_current_path(edit_merchant_discount_path(merch_1, disc_1))
        
        within('#flash-alert') do
          expect(page).to have_content('Error: Percent must be less than 100, Threshold must be greater than 0')
        end
      end
    end
  end
end