class Website < ApplicationRecord
  belongs_to :category, counter_cache: true
  has_one_attached :logo
end
