class FlowsPattern < ApplicationRecord
  default_scope -> { order(id: :asc) }
  belongs_to :flow, counter_cache: :patterns_count
  belongs_to :pattern, counter_cache: :flows_count
end
