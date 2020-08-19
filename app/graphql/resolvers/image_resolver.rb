require 'search_object/plugin/graphql'
require 'graphql/query_resolver'
module Resolvers
  class ImageResolver
    include SearchObject.module(:graphql)

    scope { Image.all }

    type [Types::ImageType]

    class ImageFilter < ::Types::BaseInputObject
      #argument :OR, [self], required: false
      #argument :description_contains, String, required: false
      #argument :url_contains, String, required: false
      argument :website_id, [ID], required: false
      argument :pattern_id, [ID], required: false
      argument :element_id, [ID], required: false
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

    def apply_filter(scope, value)
      # branches = normalize_filters(value).reduce { |a, b| a.or(b) }
      # scope.merge branches
      #puts value.to_h
      #scope.where(value.to_h)
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

    # def normalize_filters(value, branches = [])
    #   scope = Link.all
    #   if value[:description_contains]
    #     scope = scope.where('description LIKE ?', "%#{value[:description_contains]}%")
    #   end
    #   if value[:url_contains]
    #     scope = scope.where('url LIKE ?', "%#{value[:url_contains]}%")
    #   end
    #
    #   branches << scope
    #
    #   if value[:OR].present?
    #     value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) }
    #   end
    #
    #   branches
    # end

    def apply_first(scope, value)
      scope.limit(value)
    end

    def apply_skip(scope, value)
      scope.offset(value)
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
