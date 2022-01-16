require 'rails_helper'

RSpec.describe 'merchants/discounts/new.html.erb', type: :feature do
  let!(:merch_1) { create(:merchant) }

  before(:each) { visit new_merchant_discount_path(merch_1) }

  context 'as a merchant' do
    describe 'viewable page elements' do
      it 'displays submit, and number fields for percent, threshold' do
        expect(page).to have_field('discount_percent', type: 'number')
        expect(page).to have_field('discount_threshold', type: 'number')
        expect(page).to have_button('Create Discount')
      end
    end

    describe 'creating a new discount with form' do
      it 'can create new discount and display on merchant discounts index' do
        fill_in 'discount_percent', with: 77
        fill_in 'discount_threshold', with: 33
        click_button 'Create Discount'
        new_discount = merch_1.discounts.last

        expect(page).to have_current_path(merchant_discounts_path(merch_1))
        expect(page).to have_content('77% off 33 or more items')
      end

      it 'redirects back to create new discount if given invalid data' do
        fill_in 'discount_percent', with: 101
        fill_in 'discount_threshold', with: 0
        click_button 'Create Discount'

        expect(page).to have_current_path(new_merchant_discount_path(merch_1))
        
        within('#flash-alert') do
          expect(page).to have_content('Error: Percent must be less than 100, Threshold must be greater than 0')
        end
      end
    end
  end
end