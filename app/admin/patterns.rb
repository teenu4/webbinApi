ActiveAdmin.register Pattern do

  index do
    selectable_column
    id_column
    column :name
    column :tag
    actions
  end

  permit_params :name

  form do |f|
    f.inputs do
      f.input :name
    end
    actions
  end

end
