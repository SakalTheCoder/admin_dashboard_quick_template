class AddFieldsToAdmin < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :role, :integer
    add_column :admins, :username, :string
  end
end
