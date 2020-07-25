class Image < ApplicationRecord
  has_many :images_elements#, dependent: :delete_all
  has_many :elements, through: :images_elements
  before_save :set_platforms_info
  has_one_attached :desktop_file
  has_one_attached :mobile_file
  has_one_attached :tablet_file
  accepts_nested_attributes_for :images_elements, :allow_destroy => true

  PLATFORMS = %w[mobile desktop tablet].freeze

  def set_platforms_info
    attributes = {}
    PLATFORMS.each do |platform|
      attributes["#{platform}_attached"] = send("#{platform}_file").send('attached?')
    end
    attributes[:platforms_count] = attributes.count { |_, v| v }
    # can't use counter cache with activeadmin :(
    # attributes[:elements_count] = elements.count
    assign_attributes(attributes)
  end
end
