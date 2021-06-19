class AddPaymentCategoryToCharge < ActiveRecord::Migration[6.1]
  def change
    add_column :charges, :payment_category, :integer, null:false
  end
end
