require 'rails_helper'

RSpec.describe 'merchants/discounts/show.html.erb', type: :feature do
  context 'as a merchant' do
    describe 'viewable page elements' do
      it 'displays the discounts percent and threshold values' do
        merch_1 = create(:merchant)
        disc_1 = create(:discount, merchant: merch_1, percent: 37, threshold: 77)
        disc_2 = create(:discount, merchant: merch_1, percent: 3, threshold: 6)
        visit merchant_discount_path(merch_1, disc_1)

        expect(page).to have_content("Percent off: #{disc_1.percent}%")
        expect(page).to have_content("Threshold Quantity: #{disc_1.threshold}")

        expect(page).to have_no_content("Percent off: #{disc_2.percent}%")
        expect(page).to have_no_content("Threshold Quantity: #{disc_2.threshold}")
      end
    end
  end
end