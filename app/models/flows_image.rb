class FlowsImage < ApplicationRecord
  scope :default_order, -> { order(:position, :id) }
  belongs_to :flow, counter_cache: :images_count
  belongs_to :image, counter_cache: :flows_count
end
