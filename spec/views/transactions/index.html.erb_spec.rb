require 'rails_helper'

RSpec.describe "transactions/index", type: :view do
  it "displays a list of transfer transactions" do
    assign(:transactions, [
      Transaction.create!(
        transaction_hash: "abc123",
        block_hash: "block123",
        height: 42,
        sender: "alice",
        receiver: "bob",
        deposit: "1000",
        action_type: "transfer"
      ),
      Transaction.create!(
        transaction_hash: "def456",
        block_hash: "block456",
        height: 43,
        sender: "carol",
        receiver: "dave",
        deposit: "2000",
        action_type: "transfer"
      )
    ])

    render

    expect(rendered).to match("alice")
    expect(rendered).to match("bob.")
    expect(rendered).to match("1000")

    expect(rendered).to match("carol")
    expect(rendered).to match("dave")
    expect(rendered).to match("2000")
  end
end
