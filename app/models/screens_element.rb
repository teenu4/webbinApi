class ScreensElement < ApplicationRecord
  default_scope -> { order(id: :asc) }
  belongs_to :screen, counter_cache: :elements_count
  belongs_to :element
end
