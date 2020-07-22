class ImagesElement < ApplicationRecord
  default_scope -> { order(id: :asc) }
  belongs_to :image, counter_cache: :elements_count
  belongs_to :element
end
