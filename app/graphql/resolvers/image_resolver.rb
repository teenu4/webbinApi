require 'search_object/plugin/graphql'
require 'graphql/query_resolver'
module Resolvers
  class ImageResolver
    include SearchObject.module(:graphql)
    include CommonMethods

    scope { Image.all }

    type [Types::ImageType]

    class ImageFilter < ::Types::BaseInputObject
      argument :website_id, [ID], required: false
      argument :pattern_id, [ID], required: false
      argument :element_id, [ID], required: false
      argument :category_id, [ID], required: false
      argument :flow_id, [ID], required: false
    end

    class ImageOrderBy < ::Types::BaseEnum
      value 'createdAt_DESC'
      value 'internalName_ASC'
    end

    option :filter, type: ImageFilter, with: :apply_filter, default: {}
    option :first, type: types.Int, with: :apply_first
    option :skip, type: types.Int, with: :apply_skip
    option :order_by, type: ImageOrderBy, default: 'createdAt_DESC'
    option :count, type: Boolean, with: :apply_count

    def apply_filter(scope, value)
      process_filters(scope, value)
    end

    def process_filters(scope, value)
      if value[:pattern_id]
        scope = scope.joins(:images_patterns).merge(ImagesPattern.where(pattern_id: value[:pattern_id]))
      end
      if value[:element_id]
        scope = scope.joins(:images_elements).merge(ImagesElement.where(element_id: value[:element_id]))
      end
      if value[:flow_id]
        scope = scope.joins(:flows_images).merge(FlowsImage.where(flow_id: value[:flow_id]))
      end
      if value[:category_id]
        scope = scope.joins(:website).merge(Website.where(category_id: value[:category_id]))
      end
      scope = filter_by_website(scope, value)
      scope.distinct
    end

    def filter_by_website(scope, value)
      # this should work for gql filter param & default has_many images from website
      if value[:website_id].present? || object.class.name == 'Website'
        filter_hash = { website_id: value[:website_id] || object&.id }
        scope = scope.where(filter_hash)
      end
      scope
    end

    def apply_order_by_with_created_at_desc(scope)
      scope.order('created_at DESC')
    end

    def apply_order_by_with_internal_name_asc(scope)
      scope.order('internal_name ASC, id ASC')
    end

    def fetch_results
      # NOTE: Don't run QueryResolver during tests
      return super unless context.present?

      GraphQL::QueryResolver.run(Image, context, Types::ImageType) do
        super
      end
    end
  end
end
