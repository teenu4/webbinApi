class Website < ApplicationRecord
  belongs_to :category, counter_cache: true
  has_one_attached :logo
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true

  DEFAULT_URL = "#{ENV['API_ROOT']}/placeholder.png".freeze
  UPDATED_INTERVAL = 7

  def logo_url
    if logo.attached?
      logo.service_url
    else
      DEFAULT_URL
    end
  end

  # use this for 'updated' status
  def label
    'UPDATED' if last_update && (last_update + UPDATED_INTERVAL < DateTime.now)
  end
end
