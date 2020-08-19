class Image < ApplicationRecord
  belongs_to :website
  has_many :flows_images
  has_many :flows, through: :flows_images
  has_many :images_elements
  has_many :elements, through: :images_elements
  has_many :images_patterns
  has_many :patterns, through: :images_patterns
  before_save :set_platforms_info
  after_create :after_create
  has_one_attached :desktop_file
  has_one_attached :mobile_file
  has_one_attached :tablet_file
  has_one_attached :preview_file

  accepts_nested_attributes_for :images_elements, allow_destroy: true
  accepts_nested_attributes_for :images_patterns, allow_destroy: true

  PLATFORMS = %w[mobile desktop tablet].freeze
  DEFAULT_URL = "#{ENV['API_ROOT']}/placeholder.png".freeze

  def preview_url
    if desktop_attached && !preview_file.attached?
      Images::PreviewCreator.call(image: self)
      preview_file.service_url
    elsif preview_file.attached?
      preview_file.service_url
    else
      DEFAULT_URL
    end
  end

  def mobile_url
    mobile_attached ? mobile_file.service_url : DEFAULT_URL
  end

  def desktop_url
    desktop_attached ? desktop_file.service_url : DEFAULT_URL
  end

  def tablet_url
    tablet_attached ? tablet_file.service_url : DEFAULT_URL
  end

  def versions
    Images::VersionGetter.call(image: self).versions
  end

  private

  def after_create
    Images::NewVersionCreator.call(image: self) if prev_image_id
    update_website_last_update
  end

  def update_website_last_update
    website.update(last_update: created_at)
  end

  def set_platforms_info
    # deleting old preview file since new file is uploaded
    if desktop_file.attached? && preview_file.attached? && desktop_file.changed_for_autosave?
      preview_file.purge
    end
    setup_cached_fields
  end

  def setup_cached_fields
    attributes = {}
    PLATFORMS.each do |platform|
      attributes["#{platform}_attached"] = send("#{platform}_file").send('attached?')
    end
    attributes[:platforms_count] = attributes.count { |_, v| v }
    assign_attributes(attributes)
  end
end
