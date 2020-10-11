# frozen_string_literal: true

class PostTag < ApplicationRecord
  belongs_to :post, inverse_of: :post_tags
  belongs_to :tag,  inverse_of: :post_tags

  validates :post, presence: true
  validates :tag,  presence: true

  accepts_nested_attributes_for :tag
end
