class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_one :merchant, through: :item
  has_many :discounts, through: :merchant

  enum status: ['pending', 'packaged', 'shipped']

  validates_presence_of :quantity, :unit_price, :status, :invoice_id, :item_id

  # Class methods
  scope :total_revenue, -> { select('SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue').group(:id) }

  scope :not_shipped, -> { where('invoice_items.status != ?', 2) }

  # Instance Methods
  def best_discount
    discounts.order(percent: :desc).where('threshold <= :quantity', quantity: self.quantity).first
  end

  def potential_revenue
    unit_price * quantity
  end
end
