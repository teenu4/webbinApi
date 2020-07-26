ActiveAdmin.register Element do

  permit_params :name
  form do |f|
    f.inputs do
      f.input :name
    end
    actions
  end

end
