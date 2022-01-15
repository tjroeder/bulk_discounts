class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @enabled_merchants = Merchant.enabled_merchants
    @disabled_merchants = Merchant.disabled_merchants
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new

  end

  def create
    @merchant = Merchant.create!(name: params[:name])
    @merchant.save
    redirect_to admin_merchants_path
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if params[:status] == 'Disabled'
      merchant.update(status: 'Enabled')
      redirect_to admin_merchants_path
    elsif params[:status] == 'Enabled'
      merchant.update(status: 'Disabled')
      redirect_to admin_merchants_path
    else
      merchant.update(merchant_params)
      merchant.save
      flash[:notice] = "The Merchant has been updated!"
      redirect_to admin_merchant_path(merchant)
    end
  end

  private
  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
