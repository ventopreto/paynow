class AddBillingDueDateToCharges < ActiveRecord::Migration[6.1]
  def change
    add_column :charges, :billing_due_date, :string
  end
end
