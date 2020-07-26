class Pattern < ApplicationRecord
  belongs_to :image
  belongs_to :website
  has_many :flows_patterns
  before_save :set_auto_attrs

  def set_auto_attrs
    self.tag = Helpers::CommonFields.get_tag(name)
  end
end
