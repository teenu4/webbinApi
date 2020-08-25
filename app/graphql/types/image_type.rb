module Types
  class ImageType < BaseObject
    field :id, ID, null: false
    field :internal_name, String, null: true
    field :display_name, String, null: true
    field :mobile_attached, Boolean, null: true
    field :desktop_attached, Boolean, null: true
    field :tabled_attached, Boolean, null: true
    field :platforms_count, Integer, null: true
    field :elements_count, Integer, null: true
    field :latest_image_id, Integer, null: true
    field :website, Types::LightWebsiteType, null: true do
      preload :website
    end
    field :elements, [Types::ElementType], null: true do
      preload :elements
    end
    field :patterns, [Types::PatternType], null: true do
      preload :patterns
    end
    field :flows, [Types::FlowType], null: true do
      preload :flows
    end
    field :preview_url, String, null: true, resolve: -> (obj, args, context) {
      Loaders::ActiveStorageLoader.attachment_url(obj, :Image, :preview_file)
    }
    field :mobile_url, String, null: true, resolve: -> (obj, args, context) {
      Loaders::ActiveStorageLoader.attachment_url(obj, :Image, :mobile_file)
    }
    field :desktop_url, String, null: true, resolve: -> (obj, args, context) {
      Loaders::ActiveStorageLoader.attachment_url(obj, :Image, :desktop_file)
    }
    field :tablet_url, String, null: true, resolve: -> (obj, args, context) {
      Loaders::ActiveStorageLoader.attachment_url(obj, :Image, :tablet_file)
    }
    field :image_versions, [Types::ImageVersionType], null: true

    def image_versions
      object.versions
    end
  end
end
