class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    item = Item.new(item_params)
    item.save
    redirect_to merchant_items_path(params[:merchant_id])
  end

  def update
    item = Item.find(params[:id])
    if params[:status] == 'Disabled'
      item.update(status: 'Enabled')
      redirect_to merchant_items_path(params[:merchant_id])
    elsif params[:status] == 'Enabled'
      item.update(status: 'Disabled')
      redirect_to merchant_items_path(params[:merchant_id])
    else
      item.update(item_params)
      redirect_to merchant_item_path(params[:merchant_id], item)
      flash[:notice] = 'Your item has been updated!'
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id,)
  end
end
