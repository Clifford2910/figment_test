require 'rails_helper'

RSpec.describe FetchTransactions do
  let(:mock_response) do
    [
      {
        "hash" => "abc123",
        "block_hash" => "block123",
        "height" => 1,
        "action" => {
          "type" => "transfer",
          "from" => "alice.near",
          "to" => "bob.near",
          "deposit" => "1000"
        }
      },
      {
        "hash" => "def456",
        "block_hash" => "block456",
        "height" => 2,
        "action" => {
          "type" => "stake", # should be ignored
          "from" => "bob.near",
          "to" => "staking.pool",
          "deposit" => "500"
        }
      }
    ]
  end

  before do
    stub_request(:get, /near\/transactions/).to_return(
      body: mock_response.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )
  end

  it "stores only transfer transactions" do
    expect {
      FetchTransactions.call
    }.to change { Transaction.count }.by(1)

    tx = Transaction.last
    expect(tx.transaction_hash).to eq("abc123")
    expect(tx.sender).to eq("alice.near")
    expect(tx.receiver).to eq("bob.near")
    expect(tx.deposit).to eq("1000")
    expect(tx.action_type).to eq("transfer")
  end
end