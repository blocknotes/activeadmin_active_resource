# frozen_string_literal: true

module Models
  class Tag < Sequel::Model(DB)
    def validate
      super
      errors.add(:name, 'cannot be empty') if !name || name.empty?
    end

    class << self
      def raw_dataset
        DB[Models::Tag.table_name]
      end
    end
  end
end
