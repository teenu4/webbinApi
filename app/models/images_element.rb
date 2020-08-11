class ImagesElement < ApplicationRecord
  scope :default_order, -> { order(id: :asc) }
  belongs_to :image, counter_cache: :elements_count
  belongs_to :element
end
