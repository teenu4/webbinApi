ActiveAdmin.register Image do

  index do
    selectable_column
    id_column
    column :mobile_attached
    column :desktop_attached
    column :tablet_attached
    column :platforms_count
    column :elements_count
    actions
  end

  show do

    def default_attribute_table_rows
      active_admin_config.resource_columns.append :platforms_count, :elements_count, :patterns, :elements
    end

    default_main_content
  end

  permit_params :mobile_file, :desktop_file, :tablet_file,
                images_elements_attributes: %i[id image_id element_id _destroy],
                patterns_attributes: %i[id image_id name website_id]
  form do |f|
    f.inputs do
      f.input :mobile_file, as: :file
      f.input :desktop_file, as: :file
      f.input :tablet_file, as: :file
    end

    f.inputs 'Elements' do
      f.has_many :images_elements,
                 allow_destroy: true do |s|
        s.input :image_id, as: :hidden
        s.input :element_id, as: :select, collection: Element.all.pluck(:name, :id)
      end
    end

    f.inputs "Patterns" do
      f.has_many :patterns,
                 allow_destroy: true do |p|
        p.input :name
        p.input :website_id, as: :select, collection: Website.all.pluck(:name, :id)
      end
    end
    f.actions
  end

end
