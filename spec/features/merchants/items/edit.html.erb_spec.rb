require 'rails_helper'

RSpec.describe 'items/edit', type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Joe Shmoe')
    @item_1 = @merchant_1.items.create!(name: 'Light Machine', description: 'Revolutionary Device', unit_price: 999)
    visit edit_merchant_item_path(@merchant_1, @item_1)
  end
  it 'has existing info' do
    expect(page).to have_field(:name, with: 'Light Machine')
    expect(page).to have_field(:description, with: 'Revolutionary Device')
    expect(page).to have_field(:unit_price, with: 999)
  end

  it 'fills in with new info' do
    fill_in(:name, with: 'Flash Light')
    fill_in(:description, with: 'Ordinary device')
    fill_in(:unit_price, with: 99)
    expect(page).to have_field(:name, with: 'Flash Light')
    expect(page).to have_field(:description, with: 'Ordinary device')
    expect(page).to have_field(:unit_price, with: 99)
    click_button 'Save Changes'
    expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))
    expect(page).to have_content('Flash Light')
  end
end
