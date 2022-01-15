class MerchantDiscountsController < ApplicationController
  before_action :find_merchant, only: [:index, :new, :create, :destroy]
  
  def index
    @discs = @merch.discounts
  end

  def show
    @disc = Discount.find(params[:id])
  end

  def new
  end
  
  def create
    discount = @merch.discounts.new(discount_params[:discount])
    
    if discount.save 
      redirect_to merchant_discounts_path(@merch)
    else
      redirect_to new_merchant_discount_path(@merch)
      flash[:alert] = "Error: #{error_message(discount.errors)}"
    end
  end
  
  def destroy
    Discount.find(discount_params[:id]).destroy

    redirect_to merchant_discounts_path(@merch)
  end

  private

  def find_merchant
    @merch = Merchant.find(params.permit(:merchant_id)[:merchant_id])
  end

  def discount_params
    params.permit(:merchant_id, :id, discount: [:percent, :threshold])
  end
end