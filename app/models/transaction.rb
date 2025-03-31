class Transaction < ApplicationRecord
    validates :transaction_hash, presence: true, uniqueness: true
    validates :sender, :receiver, :deposit, presence: true

    scope :transfers, -> { where(action_type: "transfer") }
end
