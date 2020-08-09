module Types
  class ImageVersionType < Types::BaseObject
    field :id, ID, null: false
    field :created_at, String, null: true
    field :end_date, String, null: true
  end
end
