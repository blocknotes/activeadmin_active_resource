# frozen_string_literal: true

ActiveAdmin.register Author do
  controller do
    def permitted_params
      params.permit!
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :id, as: :hidden unless f.object.new_record? # Required
      f.input :name
      f.input :age
      f.input :email
    end

    f.actions
  end
end
