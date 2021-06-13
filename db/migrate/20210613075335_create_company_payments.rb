class CreateCompanyPayments < ActiveRecord::Migration[6.1]
  def change
    create_table :company_payments do |t|
      t.references :company, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
