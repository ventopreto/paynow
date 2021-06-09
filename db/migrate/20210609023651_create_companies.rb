class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.integer :cnpj, null:false
      t.string :corporate_name, null:false
      t.string :billing_address, null:false
      t.string :email, null:false
      t.string :email_domain

      t.timestamps
    end
  end
end
