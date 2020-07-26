class CreatePatterns < ActiveRecord::Migration[6.0]
  def change
    create_table :patterns do |t|
      t.string :name
      t.string :tag
      t.belongs_to :image
      t.belongs_to :website
      t.datetime :last_update
      t.integer :flows_count, default: 0
      t.timestamps
    end
  end
end
