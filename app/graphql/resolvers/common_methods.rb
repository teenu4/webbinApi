module Resolvers
  module CommonMethods
    def apply_first(scope, value)
      scope.limit(value)
    end

    def apply_skip(scope, value)
      scope.offset(value)
    end

    def apply_count(scope, value)
      if value
        scope.count
      else
        scope
      end
    end
  end
end