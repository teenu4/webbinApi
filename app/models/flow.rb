class Flow < ApplicationRecord
  has_many :flows_images
  belongs_to :website
  has_many :images, through: :flows_images
  accepts_nested_attributes_for :flows_images, allow_destroy: true
end
