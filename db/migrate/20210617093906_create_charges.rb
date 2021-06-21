class CreateCharges < ActiveRecord::Migration[6.1]
  def change
    create_table :charges do |t|
      t.references :end_user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.string :token
      t.integer :status, default:0, null:false
      t.decimal :original_value
      t.decimal :value_with_discount
      t.references :boleto, null: true, foreign_key: true
      t.references :pix, null: true, foreign_key: true
      t.references :credit_card, null: true, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true
      t.integer :credit_card_number
      t.string :cardholder_name
      t.integer :cvv
      t.integer :payment_category, null: false
      t.string :address
      t.date :effective_payment_date
      t.date :payment_attempt_date
      t.string :last_status

      t.timestamps
    end
  end
end
