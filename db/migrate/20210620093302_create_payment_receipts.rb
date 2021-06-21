class CreatePaymentReceipts < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_receipts do |t|
      t.string :effective_payment_date
      t.string :billing_due_date
      t.string :authorization_code
      t.references :charge, null: false, foreign_key: true

      t.timestamps
    end
  end
end
