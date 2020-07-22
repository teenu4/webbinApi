module Types
  class MutationType < Types::BaseObject

    field :create_element, mutation: Mutations::Elements::CreateElement

    field :update_image, mutation: Mutations::Images::UpdateImage

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end
  end
end
