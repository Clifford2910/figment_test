require 'net/http'
require 'uri'
require 'json'

class FetchTransactions
  API_URL = "https://4816b0d3-d97d-47c4-a02c-298a5081c0f9.mock.pstmn.io/near/transactions"
  API_KEY = ENV.fetch("API_KEY")

  def self.call
    uri = URI("#{API_URL}?api_key=#{API_KEY}")
    response = Net::HTTP.get_response(uri)
    raise "API request failed: #{response.code}" unless response.is_a?(Net::HTTPSuccess)
  
    transactions = JSON.parse(response.body)
    puts JSON.pretty_generate(transactions.first)
  
    transactions.each do |tx|
      action = tx["actions"]&.first
      next unless action && action["type"].to_s.downcase == "transfer"
  
      Rails.logger.debug "Processing transaction #{tx['hash']}..."
  
      Transaction.find_or_initialize_by(transaction_hash: tx["hash"]).update!(
        block_hash: tx["block_hash"],
        height: tx["height"],
        sender: tx["sender"],
        receiver: tx["receiver"],
        deposit: action["data"]["deposit"],
        action_type: action["type"].downcase
      )
    end
  end
end