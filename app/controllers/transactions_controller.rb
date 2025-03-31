class TransactionsController < ApplicationController
  def index
    # In a real-world app, syncing would be done via a background job or cron, not in the controller directly
    # Adding this here for the test as its a nice way to show off the full loop without needing to manually trigger anything.
    FetchTransactions.call
    @transactions = Transaction.transfers.order(height: :desc)
  end
end
