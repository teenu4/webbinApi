module Helpers
  class CommonFields
    class << self
      def get_tag(name)
        name.to_s.strip.downcase.gsub(/[^0-9a-z ]/i, '').gsub(' ', '_')
      end

      def get_last_update(obj)
        # TODO: discuss and implement
      end
    end
  end
end