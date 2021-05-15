# frozen_string_literal: true

module Models
  class Author < Sequel::Model(DB)
    class << self
      def raw_dataset
        DB[Models::Author.table_name]
      end
    end
  end
end
