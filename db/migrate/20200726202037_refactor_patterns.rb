class RefactorPatterns < ActiveRecord::Migration[6.0]
  def change
    drop_table :flows_patterns, if_exists: true
    create_table :flows_images do |t|
      t.references :flow
      t.references :image
      t.datetime :created_at, null: false
    end
    add_index :flows_images, [:flow_id, :image_id]

    remove_column :patterns, :image_id, if_exists: true
    remove_column :patterns, :flows_count, if_exists: true
    remove_column :patterns, :website_id, if_exists: true
    remove_column :patterns, :last_update, if_exists: true

    add_column :images, :flows_count, :integer, default: 0
    add_column :images, :patterns_count, :integer, default: 0
    add_column :images, :website_id, :integer
    rename_column :flows, :patterns_count, :images_count

    create_table :images_patterns do |t|
      t.references :image
      t.references :pattern
      t.datetime :created_at, null: false
    end
    add_index :images_patterns, [:image_id, :pattern_id]
    add_column :images, :name, :string
  end
end
