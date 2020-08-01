module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :elements, [Types::ElementType], null: false

    field :images, [Types::ImageType], null: false

    field :image, Types::ImageType, null: false do
      argument :id, ID, required: true
    end

    field :websites, [Types::WebsiteType], null: false

    field :website, Types::WebsiteType, null: false do
      argument :id, ID, required: true
    end

    def websites
      Website.all.order(created_at: :desc)
    end

    def website(id:)
      Website.find(id)
    end

    def elements
      Element.all
    end

    def images
      Image.all
      # order(position: :asc, id: :asc)
    end

    def image(id:)
      Image.find(id)
    end
  end
end
