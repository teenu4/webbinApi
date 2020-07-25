ActiveAdmin.register Image do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  index do
    selectable_column
    id_column
    column :mobile_attached
    column :desktop_attached
    column :tablet_attached
    column :platforms_count
    column :elements_count
  end
  permit_params :desktop_file, :tablet_file, :mobile_file,
                images_elements_attributes: %i[id image_id element_id _destroy]
  form do |f|
    f.inputs do
      f.input :desktop_file, as: :file
      # f.input :elements, :as => :check_boxes
    end

    # f.inputs do
    #   f.has_many :elements, heading: 'Elements',
    #              allow_destroy: true,
    #              new_record: true do |a|
    #     #a.input :name
    #     a.input :id, as: :check_boxes, collection: Element.all.pluck(:name, :id)#, input_html: { class: "chosen-input",  style: "width: 300px;"}
    #
    #     end
    #
    # end
    f.inputs "Elements" do
      f.has_many :images_elements,
                 allow_destroy: true do |s|
        # puts s.object.inspect
        s.input :image_id, as: :hidden
        s.input :element_id, as: :select, collection: Element.all.pluck(:name, :id)
      end
    end

    # inputs 'Elements' do
    #   input :element_ids, collection: Element.all.pluck(:name, :id), as: :select, multiple: true, input_html: { class: "chosen-input",  style: "width: 300px;"}
    # end
    f.actions
  end

  #
  #
  # or
  #
  # permit_params do
  #   permitted = [:mobile_attached, :desktop_attached, :tablet_attached, :platforms_count, :elements_count]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
