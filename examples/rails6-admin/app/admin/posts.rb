# frozen_string_literal: true

ActiveAdmin.register Post do
  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    selectable_column
    id_column
    column :title
    column :author
    column :published
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :author
      row :title
      row :description
      row :category
      row :dt
      row :position
      row :published
      row :tags
      row :created_at
      row :updated_at
    end
    # active_admin_comments # NOTE: comments not working
  end

  form do |f|
    f.semantic_errors

    f.inputs 'Post' do
      f.input :id, as: :hidden unless f.object.new_record? # Required
      f.input :author_id
      f.input :title
      f.input :description
      f.input :category
      f.input :published
      f.input :dt
      f.input :position
    end

    f.actions
  end
end
