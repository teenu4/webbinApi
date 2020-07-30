class Image < ApplicationRecord
  belongs_to :website
  has_many :flows_images
  has_many :images_elements
  has_many :elements, through: :images_elements
  has_many :images_patterns
  has_many :patterns, through: :images_patterns
  before_save :set_platforms_info
  has_one_attached :desktop_file
  has_one_attached :mobile_file
  has_one_attached :tablet_file
  has_one_attached :preview_file

  accepts_nested_attributes_for :images_elements, allow_destroy: true
  accepts_nested_attributes_for :images_patterns, allow_destroy: true

  PLATFORMS = %w[mobile desktop tablet].freeze

  def preview_url
    if desktop_attached && !preview_file.attached?
      Images::PreviewCreator.call(image: self)
      preview_file.service_url
    elsif preview_file.attached?
      preview_file.service_url
    else
      # TODO: add default url
      nil
    end
  end

  def set_platforms_info
    # deleting old preview file since new file is uploaded
    if desktop_file.attached? && preview_file.attached? && desktop_file.changed_for_autosave?
      preview_file.purge
    end
    attributes = {}
    PLATFORMS.each do |platform|
      attributes["#{platform}_attached"] = send("#{platform}_file").send('attached?')
    end
    attributes[:platforms_count] = attributes.count { |_, v| v }
    assign_attributes(attributes)
  end

  def active_admin_title
    "#{website.name} > #{name}"
  end
end
