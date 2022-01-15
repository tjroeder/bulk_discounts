class MerchantInvoiceItemsController < ApplicationController
  def update
    @merchant = Merchant.find(set_merchant[:merchant_id])
    invoice_item = InvoiceItem.find(set_invoice_item[:id])
    invoice_item.update!(status: set_invoice_item[:invoice_item][:status])

    redirect_to [@merchant, invoice_item.invoice]
  end

  private

  def set_invoice_item
    params.permit(:id, invoice_item: :status)
  end

  def set_merchant
    params.permit(:merchant_id)
  end
end