require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'relationships' do
    it { should belong_to(:invoice) }
  end

  describe 'validations' do
    it { should validate_presence_of :credit_card_number }
    it { should define_enum_for(:result).with(['default', 'failed', 'success']) }
  end

  describe 'class methods' do
    describe '::successful' do
      it 'returns all successful transactions' do
        transaction_successes = create_list(:transaction, 2, :success)
        no_success = create(:transaction)

        expect(Transaction.successful).to contain_exactly(transaction_successes[0], transaction_successes[1])
        expect(Transaction.successful).not_to include(no_success)
      end
    end
  end
end
