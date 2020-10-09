module Helpers
  class QueryMethods
    class << self
      def convert_array(arr)
        " in (#{arr.join(',')})"
      end
    end
  end
end