class CreateCompanyEndUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :company_end_users do |t|
      t.references :company, null: false, foreign_key: true
      t.references :end_user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
