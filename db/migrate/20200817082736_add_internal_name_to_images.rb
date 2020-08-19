class AddInternalNameToImages < ActiveRecord::Migration[6.0]
  def change
    remove_column :images, :position
    add_column :images, :internal_name, :string
    rename_column :images, :name, :display_name
  end
end
