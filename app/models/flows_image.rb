class FlowsImage < ApplicationRecord
  default_scope -> { order(id: :asc) }
  belongs_to :flow, counter_cache: :images_count
  belongs_to :image, counter_cache: :flows_count
end
