class Element < ApplicationRecord
  has_many :images_elements#, dependent: :delete_all
  has_many :images, through: :images_elements
  before_save :set_tag

  def set_tag
    self.tag = Helpers::CommonFields.get_tag(name)
  end
end
