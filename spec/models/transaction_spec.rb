require 'rails_helper'

RSpec.describe Transaction, type: :model do
  subject { build(:transaction) }

  it { should validate_presence_of(:transaction_hash) }
  it { should validate_uniqueness_of(:transaction_hash) }
  it { should validate_presence_of(:sender) }
  it { should validate_presence_of(:receiver) }
  it { should validate_presence_of(:deposit) }

  describe '.transfers' do
    it 'returns only transfer transactions' do
      _non_transfer = create(:transaction, action_type: 'stake')
      transfer = create(:transaction, action_type: 'transfer')

      expect(Transaction.transfers).to eq([transfer])
    end
  end
end