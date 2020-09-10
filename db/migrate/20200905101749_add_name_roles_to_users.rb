class AddNameRolesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :roles, :string, array: true, default: ['USER']
    add_column :users, :platform, :string
  end
end
