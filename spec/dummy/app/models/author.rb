# frozen_string_literal: true

class Author < ApplicationRecord
  self.schema = {
    id: :integer,
    name: :string,
    age: :integer,
    email: :string,
    created_at: :datetime,
    updated_at: :datetime
  }

  has_many :posts

  has_one :profile

  def to_s
    "#{name} (#{age})"
  end
end
