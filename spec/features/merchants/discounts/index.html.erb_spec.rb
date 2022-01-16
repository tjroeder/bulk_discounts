require 'rails_helper'

RSpec.describe 'discounts/index.html.erb', type: :feature do
  let!(:merch_1) { create(:merchant) }

  let!(:disc_1) { create(:discount, merchant: merch_1) }
  let!(:disc_2) { create(:discount, merchant: merch_1) }
  let!(:disc_3) { create(:discount, merchant: merch_1) }
  let!(:disc_4) { create(:discount) }

  before(:each) { visit merchant_discounts_path(merch_1) }

  context 'as a merchant' do
    describe 'viewable page elements' do
      it 'displays a list of discounts' do
        expect(page).to have_content("#{disc_1.percent}% off #{disc_1.threshold} or more items")
        expect(page).to have_content("#{disc_2.percent}% off #{disc_2.threshold} or more items")
        expect(page).to have_content("#{disc_3.percent}% off #{disc_3.threshold} or more items")
        expect(page).to have_no_content("#{disc_4.percent}% off #{disc_4.threshold} or more items")
      end
    end

    describe 'clickable page elements' do
      it 'has discount button that redirect to their show pages' do
        within("#discount-#{disc_1.id}") do
          click_button 'View Discount'
        end
        expect(page).to have_current_path(merchant_discount_path(merch_1, disc_1))
        visit merchant_discounts_path(merch_1)
        
        within("#discount-#{disc_2.id}") do
          click_button 'View Discount'
        end
        expect(page).to have_current_path(merchant_discount_path(merch_1, disc_2))
        visit merchant_discounts_path(merch_1)

        within("#discount-#{disc_3.id}") do
          click_button 'View Discount'
        end
        expect(page).to have_current_path(merchant_discount_path(merch_1, disc_3))
      end
      
      it 'has a link to redirect to create new merchant discounts' do
        expect(page).to have_link('Create New Discount', href: new_merchant_discount_path(merch_1))
        
        click_link('Create New Discount')
        
        expect(page).to have_current_path(new_merchant_discount_path(merch_1))
      end
      
      it 'has button to delete discount and it is removed from index page' do
        within("#discount-#{disc_1.id}") do
          click_button 'Delete Discount'
        end

        expect(page).to have_current_path(merchant_discounts_path(merch_1))
        expect(page).to have_no_content("#{disc_1.percent}% off #{disc_1.threshold} or more items")
        
        within("#discount-#{disc_2.id}") do
          click_button 'Delete Discount'
        end

        expect(page).to have_current_path(merchant_discounts_path(merch_1))
        expect(page).to have_no_content("#{disc_2.percent}% off #{disc_2.threshold} or more items")
        
        within("#discount-#{disc_3.id}") do
          click_button 'Delete Discount'
        end

        expect(page).to have_current_path(merchant_discounts_path(merch_1))
        expect(page).to have_no_content("#{disc_3.percent}% off #{disc_3.threshold} or more items")
      end
    end
  end
end