ActiveAdmin.register Flow do

  permit_params :name,
                flows_patterns_attributes: %i[id flow_id pattern_id _destroy]

  index do
    selectable_column
    id_column
    column :name
    column :last_update
    column :patterns_count
    actions
  end

  show do

    def default_attribute_table_rows
      active_admin_config.resource_columns.append :patterns_count, :patterns
    end

    default_main_content
  end

  form do |f|
    f.inputs do
      f.input :name
    end

    f.inputs 'Flow Steps' do
      f.has_many :flows_patterns,
                 allow_destroy: true do |s|
        s.input :flow_id, as: :hidden
        s.input :pattern_id, as: :select, collection: Pattern.all.pluck(:name, :id)
      end
    end
    actions
  end

end
