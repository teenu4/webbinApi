module Mutations
  module Images
    class UpdateImage < Mutations::BaseMutation
      #TODO: add attachments
      argument :id, ID, required: true
      argument :element_ids, [ID], required: false#, loads: Types::ElementType

      field :image, Types::ImageType, null: true
      field :errors, [String], null: false

      def resolve(id:, element_ids:)
        ImagesElement.where(image_id: id).delete_all
        element_ids.each do |e_id|
          ImagesElement.create(image_id: id, element_id: e_id)
        end
        return_result(Image.find(id), :image)
      end
    end
  end
end


