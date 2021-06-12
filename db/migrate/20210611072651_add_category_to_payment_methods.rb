class AddCategoryToPaymentMethods < ActiveRecord::Migration[6.1]
  def change
    add_column :payment_methods, :category, :integer, null:false
  end
end
