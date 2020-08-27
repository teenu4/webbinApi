module Types
  class CountType < Types::BaseObject
    field :count, Int, null: false

    def count
      object
    end
  end
end
