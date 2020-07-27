class Flow < ApplicationRecord
  has_many :flows_images
  has_many :images, through: :flows_images
  accepts_nested_attributes_for :flows_images, allow_destroy: true
end
