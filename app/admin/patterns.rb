ActiveAdmin.register Pattern do

  index do
    selectable_column
    id_column
    column :name
    column :tag
    column :image
    column :website
    column :last_update
    column :flows_count
    actions
  end

  show do

    def default_attribute_table_rows
      active_admin_config.resource_columns.append :flows_count
    end

    default_main_content
  end

  permit_params :name, :image_id, :website_id

  form do |f|
    f.inputs do
      f.input :name
      f.input :website_id, as: :select, collection: Website.all.pluck(:name, :id)
      f.input :image_id, as: :select, collection: Image.all.pluck(:id)
    end
    actions
  end

end
