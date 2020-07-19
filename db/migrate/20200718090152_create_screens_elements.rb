class CreateScreensElements < ActiveRecord::Migration[6.0]
  def change
    create_table :screens_elements do |t|
      t.references :screen
      t.references :element
      t.datetime :created_at, null: false
    end
    add_index :screens_elements, [:screen_id, :element_id]
  end
end
