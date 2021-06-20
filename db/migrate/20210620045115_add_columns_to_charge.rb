class AddColumnsToCharge < ActiveRecord::Migration[6.1]
  def change
    add_column :charges, :effective_payment_date, :date
    add_column :charges, :payment_attempt_date, :date
    add_column :charges, :last_status, :string
  end
end
