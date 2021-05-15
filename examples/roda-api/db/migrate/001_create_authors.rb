# frozen_string_literal: true

DB.create_table(:authors) do
  primary_key :id

  String :name
  String :email
  Fixnum :age
  DateTime :created_at
  DateTime :updated_at
end
