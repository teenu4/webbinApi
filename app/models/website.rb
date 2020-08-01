class Website < ApplicationRecord
  belongs_to :category, counter_cache: true
  has_one_attached :logo
  has_many :images

  DEFAULT_URL = Rails.application.credentials[:api_root] + '/placeholder.png'.freeze

  def logo_url
    if logo.attached?
      logo.service_url
    else
      DEFAULT_URL
    end
  end
end
