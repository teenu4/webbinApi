ActiveAdmin.register Website do

  permit_params :name, :description, :category_id, :logo,
                images_attributes: [:id, :name, :mobile_file, :desktop_file, :tablet_file, :prev_image_id,
                                    { images_elements_attributes: %i[id image_id element_id _destroy] },
                                    { images_patterns_attributes: %i[id image_id pattern_id _destroy] }]

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :logo, as: :file
      f.input :category_id, as: :select, collection: Category.all.pluck(:name, :id)
      f.has_many :images,
                 heading: 'Upload New Version Of Image',
                 allow_destroy: false do |i|
        if i.object.new_record?
          i.input :name
          i.input :mobile_file, as: :file
          i.input :desktop_file, as: :file
          i.input :tablet_file, as: :file
          i.input :prev_image_id, as: :select, collection: Image.where(website: website).pluck(:name, :id)
          i.has_many :images_elements,
                     heading: 'Elements',
                     allow_destroy: true do |s|
            s.input :element_id, as: :select, collection: Element.all.pluck(:name, :id)
          end
          i.has_many :images_patterns,
                     heading: 'Patterns',
                     allow_destroy: true do |p|
            p.input :pattern_id, as: :select, collection: Pattern.all.pluck(:name, :id)
          end
        end
      end
    end
    actions
  end

  show do
    div do
      img("SRC" => website.logo_url, width: 100, height: 100, style: "display: block; margin-left: auto;margin-right: auto;")
    end

    default_main_content
  end

end
