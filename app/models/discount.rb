class Discount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  validates_presence_of :merchant
  validates_presence_of :percent, :threshold
  validates_numericality_of :percent, greater_than: 0, less_than: 100, only_integer: true
  validates_numericality_of :threshold, greater_than: 0, only_integer: true
end
