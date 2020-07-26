ActiveAdmin.register Category do

  index do
    selectable_column
    id_column
    column :name
    column :websites_count
    actions
  end

  show do

    def default_attribute_table_rows
      active_admin_config.resource_columns.append :websites_count
    end

    default_main_content
  end
  permit_params :name

end
