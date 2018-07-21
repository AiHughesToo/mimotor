class ChangeUserTypeColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :type, :string
    add_column :users, :account_type, :string
  end
end
