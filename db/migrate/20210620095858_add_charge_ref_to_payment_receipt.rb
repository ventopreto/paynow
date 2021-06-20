class AddChargeRefToPaymentReceipt < ActiveRecord::Migration[6.1]
  def change
    add_reference :payment_receipts, :charge, null: false, foreign_key: true
  end
end
