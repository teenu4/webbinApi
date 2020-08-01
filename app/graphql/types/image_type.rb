module Types
  class ImageType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :mobile_attached, Boolean, null: true
    field :desktop_attached, Boolean, null: true
    field :tabled_attached, Boolean, null: true
    field :platforms_count, Integer, null: true
    field :elements_count, Integer, null: true
    field :elements, [Types::ElementType], null: true
    field :patterns, [Types::PatternType], null: true
    field :preview_url, String, null: true
    field :mobile_url, String, null: true
    field :desktop_url, String, null: true
    field :tablet_url, String, null: true

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
  end
end
