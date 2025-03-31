require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  describe "GET /" do
    before do
      stub_request(:get, %r{near/transactions}).to_return(
        status: 200,
        body: [].to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end
end
