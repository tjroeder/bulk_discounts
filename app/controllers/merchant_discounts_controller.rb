class MerchantDiscountsController < ApplicationController
  def index
    @merch = Merchant.find(params[:merchant_id])
    @discs = @merch.discounts
  end

  def show
    @disc = Discount.find(params[:id])
  end

  def new
    @merch = Merchant.find(params[:merchant_id])
  end

  def create
    merch = Merchant.find(discount_params[:merchant_id])
    merch.discounts.create!(discount_params[:discount])

    redirect_to merchant_discounts_path(merch)
  end

  private

  def discount_params
    params.permit(:merchant_id, discount: [:percent, :threshold])
  end
end