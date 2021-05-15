# frozen_string_literal: true

ActiveAdmin.register Tag do
  filter :name_cont

  controller do
    def permitted_params
      params.permit!
    end
  end
end
