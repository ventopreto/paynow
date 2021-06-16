class CreateEndUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :end_users do |t|
      t.integer :cpf
      t.string :fullname

      t.timestamps
    end
  end
end
