class CreatePixes < ActiveRecord::Migration[6.1]
  def change
    create_table :create_pixes do |t|
      t.string :pix_key, null: false
      t.integer :bank_code, null: false
      t.references :company, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
