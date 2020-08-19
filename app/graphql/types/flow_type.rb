module Types
  class FlowType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :website, Types::LightWebsiteType, null: true
    field :last_update, String, null: true
    field :images_count, Integer, null: true
  end
end
