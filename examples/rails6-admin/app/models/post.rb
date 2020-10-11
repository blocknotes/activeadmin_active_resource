# frozen_string_literal: true

class Post < ApplicationRecord
  self.schema = {
    id: :integer,
    title: :string,
    description: :text,
    author_id: :integer,
    category: :string,
    dt: :datetime,
    position: :float,
    published: :boolean,
    created_at: :datetime,
    updated_at: :datetime
  }

  belongs_to :author

  has_many :tags
end
