require 'graphql/batch'
module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    add_field GraphQL::Types::Relay::NodeField
    add_field GraphQL::Types::Relay::NodesField

    field :elements, [Types::ElementType], null: false

    # field :images, [Types::ImageType], null: false
    field :all_images, resolver: Resolvers::ImageResolver

    field :image, Types::ImageType, null: false do
      argument :id, ID, required: true
    end

    field :websites, [Types::WebsiteType], null: false

    field :website, Types::WebsiteType, null: false do
      argument :id, ID, required: true
    end

    def websites
       Website.all.order(created_at: :desc)
      #Loaders::RecordLoader.for(Website).load_many(Website.all.pluck(:id))
    end

    def website(id:)
      Loaders::RecordLoader.for(Website).load(id)
    end

    def elements
      Element.all
    end

    def image(id:)
      Image.find(id)
    end
  end
end
