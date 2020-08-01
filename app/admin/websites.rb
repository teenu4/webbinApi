ActiveAdmin.register Website do

  permit_params :name, :description, :category_id, :logo

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :logo, as: :file
      f.input :category_id, as: :select, collection: Category.all.pluck(:name, :id)
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
