module Types
  class WebsiteType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :description, String, null: true
    field :category, Types::CategoryType, null: true
    field :images, [Types::ImageType], null: true,
                                       resolver: Resolvers::ImageResolver
    field :logo_url, String, null: true

    # def images
    #   Resolvers::ImageResolver.new do |r|
    #     r.params = { filter: { website_id: object.id } }
    #     puts r.inspect
    #   end.results
    # end

    def logo_url
      object.logo_url
    end
  end
end
