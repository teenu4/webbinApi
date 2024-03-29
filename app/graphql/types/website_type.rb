module Types
  class WebsiteType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :description, String, null: true
    field :category, Types::CategoryType, null: true
    field :images, [Types::ImageType], null: true,
                                       resolver: Resolvers::ImageResolver
    field :last_update, String, null: true
    field :logo_url, String, null: true, resolve: -> (obj, args, context) {
      Loaders::ActiveStorageLoader.attachment_url(obj, :Website, :logo)
    }
    field :label, String, null: true

    def label
      object.label
    end

  end
end
