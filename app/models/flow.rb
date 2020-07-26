class Flow < ApplicationRecord
  has_many :flows_patterns
  has_many :patterns, through: :flows_patterns
  accepts_nested_attributes_for :flows_patterns, allow_destroy: true
end
