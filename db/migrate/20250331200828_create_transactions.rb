class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.string :transaction_hash
      t.string :block_hash
      t.integer :height
      t.string :sender
      t.string :receiver
      t.string :deposit
      t.string :action_type

      t.timestamps
    end
  end
end
