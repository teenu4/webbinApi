class CreateWebsites < ActiveRecord::Migration[6.0]
  def change
    create_table :websites do |t|
      t.string :name
      t.string :description
      t.belongs_to :category
      t.timestamps
    end
  end
end
