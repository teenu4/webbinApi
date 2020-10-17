module Filters
  class ElementFilter < ::Types::BaseInputObject
    argument :category_id, [ID], required: false
    argument :pattern_id, [ID], required: false
    argument :element_id, [ID], required: false
    argument :website_id, [ID], required: false
  end
end