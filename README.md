# Figment Tech Test - Blockchain Explorer

## Overview

This project is a take-home technical assessment for Figment. The goal was to build a minimal block explorer app for a simulated NEAR blockchain. The application fetches transactions from a mocked NEAR API, stores valid transfer transactions, and displays them on a styled index page.  
Time taken: 2 hours 45 minutes to the point of writing this README

## Features

- Root index page listing all transfer transactions  
- Fields shown: sender, receiver, deposit  
- Stores historical transactions locally in the database  
- Avoids duplicate entries using transaction_hash uniqueness  
- Ignores non-transfer actions  
- Integration with a mocked API (API key required)  
- Fully tested: model, service, request, and frontend specs  
- Uses TailwindCSS for minimal and clean styling  

## Tech Stack

- Ruby on Rails 8  
- PostgreSQL  
- TailwindCSS (via TailwindCSS-Rails)  
- RSpec for testing  
- WebMock mocking external API calls  

## Setup Instructions

# Clone the repo:
git clone https://github.com/your-username/figment_test.git
cd figment_test

# Set up environment:
bundle install
yarn install # if needed for tailwind
cp .env.example .env
# Add your API_KEY in the .env file

# Set up the database:
rails db:create db:migrate

# Run the server:
rails server

# Visit:
http://localhost:3000

---

## Design Decisions & Tradeoffs

### 1. Sync Trigger in Controller

- For demonstration, `FetchTransactions.call` is run directly in the `TransactionsController#index`.  
- Ensures data is always fresh on page load.  
- Not scalable or recommended for production.  
- Would normally use a background job or cron process.  

### 2. API Parsing

- The mock API structure is somewhat nested and not documented.  
- I debugged the data structure using `puts JSON.pretty_generate(tx)` inside the service.  
- This helped discover that the `actions` field is an array, and I needed to extract the first item.  

### 3. Error Handling

- The service raises an exception if the API request fails.  
- Transactions with missing or invalid action data are skipped with a `Rails.logger.debug` message.  

### 4. Performance

- Transactions are `find_or_initialize_by(transaction_hash)` to prevent duplicates.  
- Only transfer actions are persisted.  
- Queries are scoped and ordered by `height DESC`.  

### 5. Test Coverage

- Model: validations and scope  
- Service: fetch and persist logic  
- Request: index page responds successfully  
- View: index renders expected data  
- Frontend: minimal spec to verify transfer display  

### 6. Styling

- TailwindCSS used to keep styling clean and simple.  
- Focused on readability and clarity.  

---

## Testing

# Run all tests:
bundle exec rspec

# Run a specific test:
bundle exec rspec spec/services/fetch_transactions_spec.rb

---

## Further Improvements

### Background Jobs
Use Sidekiq or ActiveJob to run `FetchTransactions` periodically instead of on every page load.

### Pagination
Paginate the index view if the transfer list grows too large.

### Filter & Search
Allow filtering by sender or receiver, and searching by transaction hash.

### Error Reporting
Improve user-facing error messages if API fails or data is missing.

### Better UI Feedback
- Add loading states  
- Show "no transfers yet" message if database is empty

### API Key Management
Store and validate the API key more securely using Rails credentials or ENV validation logic.

---

## Interesting Points

The API data shape required careful inspection. I debugged by logging sample transactions to reveal the nested `actions` array and adjusted our service accordingly.  
This insight will be documented in the repo as a helpful note.

---

## Final Notes

This app meets all the requirements in the brief and shows how I approach problem-solving, debugging, and clean iterative development under a time constraint. Looking forward to your feedback.
