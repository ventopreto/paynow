class AddTokenToEndUser < ActiveRecord::Migration[6.1]
  def change
    add_column :end_users, :token, :string
  end
end
