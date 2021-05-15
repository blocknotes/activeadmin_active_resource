# frozen_string_literal: true

module Models
  class Post < Sequel::Model(DB)
    class << self
      def raw_dataset
        DB[Models::Post.table_name]
      end
    end
  end
end
