class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.integer :service
      t.string :email
      t.references :order, null: false, foreign_key: true, type: :uuid
      t.string :auth_url
      t.string :access_code
      t.string :reference_code
      t.integer :status
      t.string :amount

      t.timestamps
    end
  end
end
