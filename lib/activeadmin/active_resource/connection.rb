# frozen_string_literal: true

module ActiveAdmin
  module ActiveResource
    module Connection
      # ref: https://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/Quoting.html#method-i-quote_column_name
      def quote_column_name(column_name)
        column_name.to_s
      end
    end
  end
end
