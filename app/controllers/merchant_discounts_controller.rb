class MerchantDiscountsController < ApplicationController
  def index
    @merch = Merchant.find(params[:merchant_id])
    @discs = @merch.discounts
  end

  def show
    @disc = Discount.find(set_discount[:id])
  end

  def new
    @merch = Merchant.find(params[:merchant_id])
  end

  private

  def set_discount
    params.permit(:merchant_id, :id)
  end
end