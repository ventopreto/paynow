class CreateCharges < ActiveRecord::Migration[6.1]
  def change
    create_table :charges do |t|
      t.references :end_user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.string :token
      t.string :status
      t.decimal :original_value
      t.decimal :value_with_discount
      t.references :boleto, null: false, foreign_key: true
      t.references :pix, null: false, foreign_key: true
      t.references :credit_card, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true
      t.integer :credit_card_number
      t.string :cardholder_name
      t.integer :cvv
      t.string :address

      t.timestamps
    end
  end
end
