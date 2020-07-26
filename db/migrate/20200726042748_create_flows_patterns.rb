class CreateFlowsPatterns < ActiveRecord::Migration[6.0]
  def change
    create_table :flows_patterns do |t|
      t.references :flow
      t.references :pattern
      t.datetime :created_at, null: false
    end
    add_index :flows_patterns, [:flow_id, :pattern_id]
  end
end
