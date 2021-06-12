class CreateBoletos < ActiveRecord::Migration[6.1]
  def change
    create_table :boletos do |t|
      t.integer :bank_code, null: false
      t.integer :agency_number, null: false
      t.integer :bank_account, null: false

      t.timestamps
    end
  end
end
