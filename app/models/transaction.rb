class Transaction < ApplicationRecord
  belongs_to :invoice
  enum result: ['default', 'failed', 'success']

  validates :credit_card_number, presence: true

  # Class Methods
  scope :successful, -> { where( result: 2) }
end
