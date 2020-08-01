ActiveAdmin.register Image do

  index do
    selectable_column
    id_column
    column :name
    column :position
    column :mobile_attached
    column :desktop_attached
    column :tablet_attached
    column :platforms_count
    column :elements_count
    column :patterns_count
    actions
  end

  show do
    div do
      img("SRC" => image.preview_url, style: "display: block; margin-left: auto;margin-right: auto;width: 50%;")
    end

    def default_attribute_table_rows
      active_admin_config.resource_columns.append :platforms_count, :elements_count, :patterns, :elements
    end

    default_main_content
  end

  permit_params :mobile_file, :desktop_file, :tablet_file, :name, :website_id, :position,
                images_elements_attributes: %i[id image_id element_id _destroy],
                images_patterns_attributes: %i[id image_id pattern_id _destroy]
  form do |f|
    f.inputs do
      f.input :name
      f.input :position
      f.input :mobile_file, as: :file
      f.input :desktop_file, as: :file
      f.input :tablet_file, as: :file
      f.input :website_id, as: :select, collection: Website.all.pluck(:name, :id)
    end

    f.inputs 'Elements' do
      f.has_many :images_elements,
                 allow_destroy: true do |s|
        s.input :image_id, as: :hidden
        s.input :element_id, as: :select, collection: Element.all.pluck(:name, :id)
      end
    end

    f.inputs "Patterns" do
      f.has_many :images_patterns,
                 allow_destroy: true do |p|
        p.input :image_id, as: :hidden
        p.input :pattern_id, as: :select, collection: Pattern.all.pluck(:name, :id)
      end
    end
    f.actions
  end

end
