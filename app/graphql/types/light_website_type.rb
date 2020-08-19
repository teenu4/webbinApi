# i can't use WebsiteType from ImageType :(
module Types
  class LightWebsiteType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :description, String, null: true
    field :category, Types::CategoryType, null: true
    field :logo_url, String, null: true

    def logo_url
      object.logo_url
    end
  end
end
