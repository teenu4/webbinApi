ActiveAdmin.register Image do

  index do
    selectable_column
    id_column
    column :internal_name
    column :display_name
    column :platforms_count
    column :elements_count
    column :patterns_count
    column :end_date
    column :prev_image_id
    column :latest_image_id
    actions
  end

  show do
    div do
      img('SRC' => image.preview_url, style: 'display: block; margin-left: auto;margin-right: auto;width: 50%;')
    end

    def default_attribute_table_rows
      active_admin_config.resource_columns.append :platforms_count, :elements_count, :patterns, :elements
    end

    default_main_content
  end

  permit_params :mobile_file, :desktop_file, :tablet_file, :internal_name, :website_id,
                :display_name, :end_date,
                images_elements_attributes: %i[id image_id element_id _destroy],
                images_patterns_attributes: %i[id image_id pattern_id _destroy]
  form do |f|
    f.inputs do
      f.input :internal_name
      f.input :display_name
      f.input :mobile_file, as: :file
      f.input :desktop_file, as: :file
      f.input :tablet_file, as: :file
      f.input :website_id, as: :select, collection: Website.all.pluck(:name, :id)
      f.input :end_date, as: :datetime_picker

    end

    f.inputs 'Elements' do
      f.has_many :images_elements,
                 allow_destroy: true do |s|
        s.input :element_id, as: :select, collection: Element.all.pluck(:name, :id)
      end
    end

    f.inputs 'Patterns' do
      f.has_many :images_patterns,
                 allow_destroy: true do |p|
        p.input :pattern_id, as: :select, collection: Pattern.all.pluck(:name, :id)
      end
    end
    f.actions
  end

end
