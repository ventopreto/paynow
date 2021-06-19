class ChangeStatusToBeIntInCharges < ActiveRecord::Migration[6.1]
  def change
    change_column :charges, :status, :integer, default:0
  end
end
