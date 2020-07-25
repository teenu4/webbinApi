ActiveAdmin.register Element do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  #  index do
  #     selectable_column
  #     id_column
  #     column :name
  #     actions
  #  end
   permit_params :name#, :tag
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :tag]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
