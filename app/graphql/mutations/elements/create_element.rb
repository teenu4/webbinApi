module Mutations
  module Elements
    class CreateElement < Mutations::BaseMutation
      argument :name, String, required: true
      field :element, Types::ElementType, null: true
      field :errors, [String], null: false

      def resolve(name:)
        element = Element.new(name: name)
        return_result(element, :element)
      end
    end
  end
end

