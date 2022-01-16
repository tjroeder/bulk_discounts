class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  enum status: ['pending', 'packaged', 'shipped']

  validates :quantity, presence: true
  validates :unit_price, presence: true

  # Class methods
  scope :total_revenue, -> { select('SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue').group(:id) }

  scope :not_shipped, -> { where('invoice_items.status != ?', 2) }
end
