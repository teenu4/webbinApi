ActiveAdmin.register Flow do

  permit_params :name,
                flows_images_attributes: %i[id flow_id image_id _destroy]

  index do
    selectable_column
    id_column
    column :name
    column :last_update
    column :images_count
    actions
  end

  show do

    def default_attribute_table_rows
      active_admin_config.resource_columns.append :images
    end

    default_main_content
  end

  form do |f|
    f.inputs do
      f.input :name
    end

    f.inputs 'Flow Steps' do
      f.has_many :flows_images,
                 allow_destroy: true do |s|
        s.input :flow_id, as: :hidden
        s.input :image, as: :select, collection: Image.all.map{|i| [i.active_admin_title,i.id]}
      end
    end
    actions
  end

end
