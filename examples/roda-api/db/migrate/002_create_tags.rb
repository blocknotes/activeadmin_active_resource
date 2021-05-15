# frozen_string_literal: true

DB.create_table(:tags) do
  primary_key :id

  String :name
  DateTime :created_at
  DateTime :updated_at
end
