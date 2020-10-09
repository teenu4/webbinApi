module Types
  class ElementType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :tag, String, null: true
    field :count, Int, null: true

    def count
      context[:counts][object.id] || 0
    end
  end
end
