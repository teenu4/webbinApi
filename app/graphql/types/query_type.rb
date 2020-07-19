module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :elements, [Types::ElementType], null: false

    def elements
      Element.all
    end

    field :screens, [Types::ScreenType], null: false

    def screens
      Screen.all
    end
  end
end
