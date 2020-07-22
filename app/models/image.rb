class Image < ApplicationRecord
  has_many :images_elements#, dependent: :delete_all
  has_many :elements, through: :images_elements
  before_save :set_platforms_info

  PLATFORMS = %w[mobile desktop tablet]

  def set_platforms_info
    self.platforms_count = PLATFORMS.count { |n| send("#{n}_attached") }
  end
end
