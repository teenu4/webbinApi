module Types
  class ScreenType < Types::BaseObject
    field :id, ID, null: false
    field :mobile_attached, Boolean, null: true
    field :desktop_attached, Boolean, null: true
    field :tabled_attached, Boolean, null: true
    field :platforms_count, Integer, null: true
    field :elements_count, Integer, null: true
    field :elements, [Types::ElementType], null: true
  end
end
