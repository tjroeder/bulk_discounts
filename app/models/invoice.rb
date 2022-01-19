class Invoice < ApplicationRecord
  include ApplicationHelper
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  has_many :merchants, through: :items
  has_many :discounts, through: :merchants

  enum status: ['in progress', 'cancelled', 'completed']

  # Class Methods
  def self.incomplete_list
    joins(:invoice_items).merge(InvoiceItem.not_shipped)
                         .select('invoices.*')
                         .group('invoices.id')
  end

  def self.order_created_at
    order('invoices.created_at')
  end

  # Instance Methods
  def created_at_formatted
    created_at.strftime("%A, %B %-d, %Y")
  end

  def customer_full_name
    self.customer.first_name + ' ' + self.customer.last_name
  end

  def items_ready_ship
    invoice_items.where('invoice_items.status = ?', 1)
  end

  def ii_filtered_by_merch(merch_id)
    invoice_items.joins(:merchant).where(merchants: { id: merch_id })
  end

  def pre_discount_revenue(merch_id)
    ii_filtered_by_merch(merch_id).sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def discounted_revenue(merch_id)
    ii_filtered_by_merch(merch_id).sum(&:line_item_revenue)
  end
end
