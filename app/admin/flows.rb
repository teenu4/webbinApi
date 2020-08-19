ActiveAdmin.register Flow do

  permit_params :name, :website_id,
                flows_images_attributes: %i[id flow_id image_id position _destroy]

  index do
    selectable_column
    id_column
    column :name
    column :last_update
    column :images_count
    column :website
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
      f.input :website_id, as: :select, collection: Website.all.pluck(:name, :id)
    end

    f.inputs 'Flow Steps' do
      f.has_many :flows_images, sortable: :position, sortable_start: 1,
                                allow_destroy: true do |s|
        unless flow.website
          f.h3 "If you don't see images - select website and save flow first"
        end
        s.input :image, as: :select, collection: Image.where(website: flow.website, end_date: nil)
                                                      .pluck(:internal_name, :id)
      end
    end
    actions
  end

end
