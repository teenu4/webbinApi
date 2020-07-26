class AddPatternsCount < ActiveRecord::Migration[6.0]
  def change
    remove_column :flows, :flows_count
    add_column :flows, :patterns_count, :integer, default: 0
  end
end
