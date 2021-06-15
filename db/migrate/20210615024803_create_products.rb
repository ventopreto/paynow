class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name, null:false
      t.decimal :price, null:false
      t.integer :discount
      t.string :token
      t.belongs_to :company, index: true

      t.timestamps
    end
  end
end
