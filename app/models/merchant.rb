class Merchant < ApplicationRecord
  # Relationships
  has_many :items
  has_many :discounts
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  
  # Validations
  validates :name, presence: true
  
  # Class Methods
  def self.top_five_merchants
     joins({invoice_items: {invoice: :transactions}})
      .where(transactions: { result: 2 })
      .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .group(:id)
      .order(revenue: :desc)
      .limit(5)
  end

  # Instance Methods
  def disabled_items
    items.where(status: "Disabled")
  end

  def enabled_items
    items.where(status: "Enabled")
  end

  def self.disabled_merchants
    where(status: "Disabled")
  end

  def self.enabled_merchants
    where(status: "Enabled")
  end

  def top_customers
     transactions.joins(invoice: :customer)
                 .where('result =?',2)
                 .select('customers.*,count(transactions) as count_transaction')
                 .group('customers.id')
                 .order(count: :desc).limit(5)
  end

  def items_ready_ship
    invoice_items.where('invoice_items.status = ?', 1)
  end

  def order_by_invoice
    invoices.order(:created_at).distinct
  end

  def top_five_items
    items.joins({invoice_items: {invoice: :transactions}})
         .select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
         .group(:id).where(transactions: {result: 2})
         .order(revenue: :desc)
         .limit(5)
  end

  def best_sales
  invoices.joins(:transactions, :invoice_items)
          .where(transactions: {result: 2})
          .group(:id)
          .select('invoices.created_at, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
          .order(revenue: :desc)
          .first
  end
end
