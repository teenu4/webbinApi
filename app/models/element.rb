class Element < ApplicationRecord
  has_many :screens_elements#, dependent: :delete_all
  has_many :screens, through: :screens_elements
  before_save :set_tag

  def set_tag
    self.tag = name.to_s.downcase.gsub(' ', '_')
  end
end
