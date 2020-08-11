class ImagesPattern < ApplicationRecord
  scope :default_order, -> { order(id: :asc) }
  belongs_to :image, counter_cache: :patterns_count
  belongs_to :pattern
end
