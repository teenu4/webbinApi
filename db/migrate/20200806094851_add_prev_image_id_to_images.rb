class AddPrevImageIdToImages < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :prev_image_id, :integer
    rename_column :images, :next_image_id, :latest_image_id
  end
end
