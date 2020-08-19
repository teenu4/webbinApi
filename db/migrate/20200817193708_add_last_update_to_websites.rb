class AddLastUpdateToWebsites < ActiveRecord::Migration[6.0]
  def change
    add_column :websites, :last_update, :datetime
  end
end
