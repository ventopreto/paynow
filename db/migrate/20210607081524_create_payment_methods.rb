class CreatePaymentMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_methods do |t|
      t.string :name
      t.float :percentage_fee
      t.decimal :max_fee

      t.timestamps
    end
  end
end
