FactoryBot.define do
  factory :transaction do
    sequence(:transaction_hash) { |n| "tx_hash_#{n}" }
    block_hash                  { "block_#{SecureRandom.hex(4)}" }
    height                      { rand(1..1000) }
    sender                      { "Jane" }
    receiver                    { "John" }
    deposit                     { "10000000000000000000000" }
    action_type                 { "transfer" }
  end
end
