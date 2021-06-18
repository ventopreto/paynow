class AddProductRefToCharge < ActiveRecord::Migration[6.1]
  def change
    add_reference :charges, :product, null: false, foreign_key: true
  end
end
