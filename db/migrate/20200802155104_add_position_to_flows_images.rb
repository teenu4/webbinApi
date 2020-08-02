class AddPositionToFlowsImages < ActiveRecord::Migration[6.0]
  def change
    add_column :flows_images, :position, :integer
  end
end
