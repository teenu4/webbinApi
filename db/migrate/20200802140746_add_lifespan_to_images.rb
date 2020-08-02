class AddLifespanToImages < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :end_date, :datetime
    add_column :images, :next_image_id, :integer
  end
end
