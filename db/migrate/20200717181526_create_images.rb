class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.boolean :mobile_attached
      t.boolean :desktop_attached
      t.boolean :tablet_attached
      t.integer :platforms_count
      t.integer :elements_count, default: 0
      t.timestamps
    end
  end
end
