module Mutations
  module Screens
    class UpdateScreen < Mutations::BaseMutation
      #TODO: add attachments
      argument :id, ID, required: true
      argument :element_ids, [ID], required: true#, loads: Types::ElementType

      field :screen, Types::ScreenType, null: true
      field :errors, [String], null: false

      def resolve(id:, element_ids:)
        ScreensElement.where(screen_id: id).delete_all
        element_ids.each do |e_id|
          ScreensElement.create(screen_id: id, element_id: e_id)
        end
        return_result(Screen.find(id), :screen)
      end
    end
  end
end


