module Types
  class ImageType < BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :mobile_attached, Boolean, null: true
    field :desktop_attached, Boolean, null: true
    field :tabled_attached, Boolean, null: true
    field :platforms_count, Integer, null: true
    field :elements_count, Integer, null: true
    field :position, Integer, null: true
    field :latest_image_id, Integer, null: true
    field :website, Types::ImageWebsiteType, null: true
    field :elements, [Types::ElementType], null: true
    field :patterns, [Types::PatternType], null: true
    field :flows, [Types::FlowType], null: true
    field :preview_url, String, null: true
    field :mobile_url, String, null: true
    field :desktop_url, String, null: true
    field :tablet_url, String, null: true
    field :image_versions, [Types::ImageVersionType], null: true

    def preview_url
      object.preview_url
    end

    def mobile_url
      object.mobile_url
    end

    def desktop_url
      object.desktop_url
    end

    def tablet_url
      object.tablet_url
    end

    def image_versions
      object.versions
    end
  end
end
