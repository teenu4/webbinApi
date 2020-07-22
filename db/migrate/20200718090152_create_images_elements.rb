class CreateImagesElements < ActiveRecord::Migration[6.0]
  def change
    create_table :images_elements do |t|
      t.references :image
      t.references :element
      t.datetime :created_at, null: false
    end
    add_index :images_elements, [:image_id, :element_id]
  end
end
