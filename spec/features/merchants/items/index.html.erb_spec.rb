require 'rails_helper'

RSpec.describe "items/index", type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Joe Shmoe")
    @merchant_2 = Merchant.create!(name: "Jane Shmoe")

    @item_1 = @merchant_1.items.create!(name: "Light Machine", description: "Revolutionary Device", unit_price: 999)
    @item_3 = @merchant_2.items.create!(name: "Molly Doll", description: "What is it", unit_price: 500)
    visit merchant_items_path(@merchant_1)
  end

  it 'has the names of merchant items' do
    expect(page).to have_content(@item_1.name)
    expect(page).to_not have_content(@item_3.name)
  end

  it 'has button that goes to new page' do
    click_link "Create New Item"
    expect(current_path).to eq(new_merchant_item_path(@merchant_1))
  end

  it 'changes status to enabled' do
    expect(@item_1.status).to eq('Disabled')
    click_button "Enable"
    expect('Enabled Items').to appear_before(@item_1.name)
    click_button 'Disable'
    expect('Disabled Items').to appear_before(@item_1.name)
  end
end
