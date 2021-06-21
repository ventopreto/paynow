class CreateBoletos < ActiveRecord::Migration[6.1]
  def change
    create_table :boletos do |t|
      t.integer :bank_code
      t.integer :agency_number
      t.integer :bank_account
      t.references :company, null: false, foreign_key: true
      t.references :payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end


