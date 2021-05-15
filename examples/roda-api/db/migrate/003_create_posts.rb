# frozen_string_literal: true

DB.create_table(:posts) do
  primary_key :id
  foreign_key :author_id, :authors

  String :title
  String :description, text: true
  String :category
  DateTime :dt
  Float :position
  TrueClass :published

  DateTime :created_at
  DateTime :updated_at
end
