require 'search_object/plugin/graphql'
require 'graphql/query_resolver'
module Resolvers
  class FlowResolver
    include SearchObject.module(:graphql)
    include CommonMethods

    scope { Flow.all }

    type [Types::FlowType]

    class FlowFilter < ::Types::BaseInputObject
      argument :category_id, [ID], required: false
      argument :name, String, required: false
    end

    class FlowOrderBy < ::Types::BaseEnum
      value 'updatedAt_DESC'
      value 'imagesCount_DESC'
    end

    option :filter, type: FlowFilter, with: :apply_filter, default: {}
    option :first, type: types.Int, with: :apply_first
    option :skip, type: types.Int, with: :apply_skip
    option :order_by, type: FlowOrderBy, default: 'updatedAt_DESC'
    option :count, type: Boolean, with: :apply_count

    def apply_filter(scope, value)
      if value[:category_id]
        scope = scope.joins(:website)
                     .where(websites: { category_id: value[:category_id] })
      end
      scope = scope.where(name: value[:name]) if value[:name]
      scope.distinct
    end

    def apply_order_by_with_updated_at_desc(scope)
      scope.order('updated_at DESC')
    end

    def apply_order_by_with_images_count_desc(scope)
      scope.order('images_count DESC')
    end

    def fetch_results
      # NOTE: Don't run QueryResolver during tests
      return super unless context.present?

      GraphQL::QueryResolver.run(Flow, context, Types::FlowType) do
        super
      end
    end
  end
end
