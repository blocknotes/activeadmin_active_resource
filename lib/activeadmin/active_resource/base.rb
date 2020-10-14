# frozen_string_literal: true

module ActiveAdmin
  module ActiveResource
    module Base
      attr_writer :inheritance_column

      # ref: https://api.rubyonrails.org/classes/ActiveRecord/AttributeMethods/ClassMethods.html#method-i-column_for_attribute
      def column_for_attribute(name)
        # => ActiveRecord::ConnectionAdapters::Column
        col_name = name.to_s
        send(:class).columns.find { |col| col.name == col_name }
      end

      module ClassMethods
        prepend(FindExt = Module.new do
          def find(*arguments)
            # First argument an array -> batch action
            if arguments.count > 0 && arguments[0].is_a?(Array)
              ret = []
              arguments[0].each do |id|
                ret << find(id)
              end
              ret.compact
            else
              super
            end
          end
        end)

        def _ransackers
          {}
        end

        # ref: https://api.rubyonrails.org/classes/ActiveRecord/ModelSchema/ClassMethods.html#method-i-content_columns
        def content_columns
          @content_columns ||= columns.reject do |c|
            # c.name == primary_key || # required to update enities
            c.name == inheritance_column ||
              c.name.end_with?("_id") ||
              c.name.end_with?("_count")
          end
        end

        # ref: http://api.rubyonrails.org/classes/ActiveRecord/ModelSchema/ClassMethods.html#method-i-column_names
        def column_names
          @column_names ||= columns.map(&:name)
        end

        # ref: http://api.rubyonrails.org/classes/ActiveRecord/ModelSchema/ClassMethods.html#method-i-columns
        def columns
          # => array of ActiveRecord::ConnectionAdapters::Column
          @columns ||= begin
            schema.map do |name, type|
              col_name = name.to_s
              col_type = type.to_sym
              col_type = :hidden if col_name == 'id'
              OpenStruct.new(name: col_name, type: col_type)
            end
          end
        end

        def find_all(options = {})
          prefix_options, query_options = split_options(options[:params])
          query_options[:limit] = query_options[:per_page]
          path = collection_path(prefix_options, query_options)
          @connection_response = connection.get(path, headers)
          instantiate_collection((format.decode( @connection_response.body ) || []), query_options, prefix_options)
        end

        # -> http://api.rubyonrails.org/classes/ActiveRecord/FinderMethods.html#method-i-find_by
        def find_by(arg, *_args)
          arg && arg['id'] ? find(arg['id']) : find(:first, arg)
        end

        # -> http://api.rubyonrails.org/classes/ActiveRecord/ModelSchema/ClassMethods.html#method-i-inheritance_column
        def inheritance_column
          (@inheritance_column ||= nil) || 'type'
        end

        # -> http://api.rubyonrails.org/classes/ActiveRecord/ModelSchema/ClassMethods.html#method-i-quoted_table_name
        def quoted_table_name
          @quoted_table_name ||= "\"#{to_s.tableize}\""
        end

        def page(page)
          @page = page.to_i
          @page = 1 if @page < 1
          self
        end

        def per(page_count)
          @per_page = page_count.to_i
          results
        end

        def ransack(params = {}, _options = {})
          @ransack_params = params.blank? ? {} : params.permit!.to_h
          OpenStruct.new(conditions: {}, object: OpenStruct.new(klass: self), result: self)
        end

        # -> http://api.rubyonrails.org/classes/ActiveRecord/Reflection/ClassMethods.html#method-i-reflect_on_all_associations
        def reflect_on_all_associations(_macro = nil)
          []
        end

        # -> http://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-reorder
        def reorder(sql)
          @order = sql
          self
        end

        def results
          results = find_all params: { page: @page, per_page: @per_page, order: @order, q: @ransack_params }
          decorate_with_pagination_data(results)
        end

        def decorate_with_pagination_data(results)
          results.current_page = @page
          results.limit_value = (@connection_response['pagination-limit'] || @per_page).to_i
          results.total_count = (@connection_response['pagination-totalcount'] || results.count).to_i
          results.total_pages = results.limit_value > 0 ? (results.total_count.to_f / results.limit_value).ceil : 1
          results
        end
      end

      def self.prepended(base)
        base.collection_parser = ActiveAdmin::ActiveResource::Results

        class << base
          prepend ClassMethods
        end  
      end 
    end
  end
end
