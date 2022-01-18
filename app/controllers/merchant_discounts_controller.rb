class MerchantDiscountsController < ApplicationController
  before_action :find_merchant
  before_action :find_discount, only: [:show, :edit, :update, :destroy]

  def index
    @discs = @merch.discounts
  end

  def show
  end

  def new
  end
  
  def create
    new_discount = @merch.discounts.new(discount_params[:discount])
    
    if new_discount.save 
      redirect_to merchant_discounts_path(@merch)
    else
      redirect_to new_merchant_discount_path(@merch)
      flash[:alert] = "Error: #{error_message(new_discount.errors)}"
    end
  end

  def edit
  end
  
  def update
    if @disc.update(discount_params[:discount])
      redirect_to merchant_discount_path(@merch, @disc)
    else
      redirect_to edit_merchant_discount_path(@merch, @disc)
      flash[:alert] = "Error: #{error_message(@disc.errors)}"
    end
  end
  
  def destroy
    @disc.destroy

    redirect_to merchant_discounts_path(@merch)
  end

  private

  def find_merchant
    id = params.permit(:merchant_id)[:merchant_id]
    @merch = Merchant.find(id)
  end

  def find_discount
    id = params.permit(:id)[:id]
    @disc = Discount.find(id)
  end

  def discount_params
    params.permit(:merchant_id, :id, discount: [:percent, :threshold])
  end
end