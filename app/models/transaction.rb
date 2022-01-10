class Transaction < ApplicationRecord
  belongs_to :invoice
  enum result: ["", 'failed', 'success'] #TODO change '' to default

  validates :credit_card_number, presence: true
  # validates :credit_card_expiration_date, presence: true
end
