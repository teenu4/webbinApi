module Helpers
  module Render
    def return_result(obj, key)
      if obj.save
        # Successful creation, return the created object with no errors
        {
          "#{key}": obj,
          errors: []
        }
      else
        # Failed save, return the errors to the client
        {
          "#{key}": nil,
          errors: obj.errors.full_messages
        }
      end
    end
  end
end