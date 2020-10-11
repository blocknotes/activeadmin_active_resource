# frozen_string_literal: true

class Tag < ApplicationRecord
  self.schema = {
    id: :integer,
    name: :string
  }

  has_many :posts
end
