class Screen < ApplicationRecord
  has_many :screens_elements#, dependent: :delete_all
  has_many :elements, through: :screens_elements
  before_save :set_platforms_info

  PLATFORMS = %w[mobile desktop tablet]

  def set_platforms_info
    self.platforms_count = PLATFORMS.count { |n| send("#{n}_attached") }
  end
end
