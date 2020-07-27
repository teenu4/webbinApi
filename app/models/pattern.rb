class Pattern < ApplicationRecord
  has_many :images_patterns#, dependent: :delete_all
  has_many :images, through: :images_patterns
  before_save :set_auto_attrs

  def set_auto_attrs
    self.tag = Helpers::CommonFields.get_tag(name)
  end
end
