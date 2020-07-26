class CreateFlows < ActiveRecord::Migration[6.0]
  def change
    create_table :flows do |t|
      t.string :name
      t.integer :flows_count
      t.datetime :last_update
      t.timestamps
    end
  end
end
