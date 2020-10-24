module Service
  class FilterCountFetcher
    include Interactor

    FIELDS_MAPPING = {
        'Images' => {
            pattern_id: { column: 'ip.pattern_id', joins: 'left join images_patterns ip on i.id = ip.image_id' },
            element_id: { column: 'ie.element_id', joins: 'left join images_elements ie on i.id = ie.image_id' },
            category_id: { column: 'c.id', joins: 'left join websites w on i.website_id = w.id
         left join categories c on w.category_id = c.id' },
            website_id: { column: 'website_id' }
        },
        'Websites' => {
            category_id: { column: 'website_id' }
        }
    }

    def call
      raw_result = query_result
      context.counts = raw_result.map { |e| [e[context.filter_type], e['count']] }.to_h
    end

    private

    def fill_where
      where = FIELDS_MAPPING[context.resource_type].map do |key, options|
        next if key.to_s == context.filter_type

        if context.filter.key?(key)
          "#{options[:column]}#{Helpers::QueryMethods.convert_array(context.filter[key])}"
        else
          nil
        end
      end.compact.join(' and ')
      where.blank? ? where : where.prepend('where ')
    end

    def fill_joins
      FIELDS_MAPPING[context.resource_type].map do |key, options|
        if context.filter.key?(key) || key.to_s == context.filter_type
          options[:joins]
        else
          nil
        end
      end.compact.join("\n")
    end

    def query_result
      "#{context.resource_type}CountQuery".constantize.call(context.filter_type,
                                                            fill_where,
                                                            fill_joins)
    end
  end
end