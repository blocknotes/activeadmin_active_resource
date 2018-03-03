module ActiveAdmin
  module ActiveResource
    class Results < ::ActiveResource::Collection
      attr_accessor :current_page, :limit_value, :total_count, :total_pages

      def initialize( elements = [] )
        super elements
        @limit_value = ActiveAdmin.application.default_per_page
        @total_count = 0
        @total_pages = 1
        @current_page = 1
      end

      def except( *params )
        self
      end

      def group_values
        nil
      end
    end
  end
end
