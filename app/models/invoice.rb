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

  def ii_filtered_by_merch(merch = nil)
    return invoice_items.joins(:merchant).where(merchants: { id: merch }) if merch
    invoice_items
  end

  def pre_discount_revenue(merch = nil)
    ii_filtered_by_merch(merch).sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def discounted_amount(merch = nil)
    Invoice.select('SUM(discount_rev.discounted_ii) AS discount_sum')
           .from(self.ii_filtered_by_merch(merch)
                     .joins(:discounts)
                     .where('invoice_items.quantity >= discounts.threshold')
                     .select('invoice_items.id, max(invoice_items.unit_price * invoice_items.quantity * discounts.percent / 100.0) AS discounted_ii')
                     .group('invoice_items.id'), :discount_rev)
  end

  def total_discounted_revenue(merch = nil)
    pre_discount_revenue(merch) - discounted_amount(merch)[0]['discount_sum'].to_f
  end 
end

