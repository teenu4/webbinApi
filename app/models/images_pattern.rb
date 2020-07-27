class ImagesPattern < ApplicationRecord
  default_scope -> { order(id: :asc) }
  belongs_to :image, counter_cache: :patterns_count
  belongs_to :pattern
end
