require 'graphql/batch'
module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    add_field GraphQL::Types::Relay::NodeField
    add_field GraphQL::Types::Relay::NodesField

    field :all_elements, [Types::ElementType], null: false

    field :all_patterns, [Types::PatternType], null: false

    field :all_categories, [Types::CategoryType], null: false

    field :all_images, resolver: Resolvers::ImageResolver

    field :images_count, CountType, resolver: Resolvers::ImageResolver

    field :image, Types::ImageType, null: false do
      argument :id, ID, required: true
    end

    field :all_websites, resolver: Resolvers::WebsiteResolver

    field :websites_count, CountType, resolver: Resolvers::WebsiteResolver

    field :website, Types::WebsiteType, null: false do
      argument :id, ID, required: true
    end

    field :all_flows, resolver: Resolvers::FlowResolver

    field :flows_count, CountType, resolver: Resolvers::FlowResolver

    def websites
       Website.all.order(created_at: :desc)
    end

    def website(id:)
      Loaders::RecordLoader.for(Website).load(id)
    end

    def all_elements
      Element.all
    end

    def all_patterns
      Pattern.all
    end

    def all_categories
      Category.all
    end

    def image(id:)
      Image.find(id)
    end
  end
end
