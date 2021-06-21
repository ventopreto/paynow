class CreatePixes < ActiveRecord::Migration[6.1]
  def change
    create_table :pixes do |t|
      t.string :pix_key
      t.integer :bank_code
      t.references :company, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end


