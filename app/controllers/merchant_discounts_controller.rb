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
    discount = merch.discounts.new(discount_params[:discount])

    if discount.save 
      redirect_to merchant_discounts_path(merch)
    else
      redirect_to new_merchant_discount_path(merch)
      flash[:alert] = "Error: #{error_message(discount.errors)}"
    end
  end

  private

  def discount_params
    params.permit(:merchant_id, discount: [:percent, :threshold])
  end
end