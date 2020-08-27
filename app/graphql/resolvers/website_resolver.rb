require 'search_object/plugin/graphql'
require 'graphql/query_resolver'
module Resolvers
  class WebsiteResolver
    include SearchObject.module(:graphql)
    include CommonMethods

    scope { Website.all }

    type [Types::WebsiteType]

    class WebsiteFilter < ::Types::BaseInputObject
      argument :category_id, [ID], required: false
    end

    class WebsiteOrderBy < ::Types::BaseEnum
      value 'lastUpdate_DESC'
      value 'name_ASC'
    end

    option :filter, type: WebsiteFilter, with: :apply_filter, default: {}
    option :first, type: types.Int, with: :apply_first
    option :skip, type: types.Int, with: :apply_skip
    option :order_by, type: WebsiteOrderBy, default: 'lastUpdate_DESC'
    option :count, type: Boolean, with: :apply_count

    def apply_filter(scope, value)
      if value[:category_id]
        scope = scope.where(category_id: value[:category_id])
      end
      scope.distinct
    end

    def apply_order_by_with_last_update_desc(scope)
      scope.order('last_update DESC')
    end

    def apply_order_by_with_name_asc(scope)
      scope.order('name ASC')
    end

    def fetch_results
      # NOTE: Don't run QueryResolver during tests
      return super unless context.present?

      GraphQL::QueryResolver.run(Website, context, Types::WebsiteType) do
        super
      end
    end
  end
end
