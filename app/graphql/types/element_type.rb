module Types
  class ElementType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :tag, String, null: true
  end
end
