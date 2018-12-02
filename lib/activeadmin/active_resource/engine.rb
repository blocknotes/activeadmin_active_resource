require 'active_admin'

module ActiveAdmin
  module ActiveResource
    class Engine < ::Rails::Engine
      engine_name 'activeadmin_active_resource'
    end
  end
end

::ActiveResource::Base.class_eval do
  attr_writer :inheritance_column

  self.collection_parser = ActiveAdmin::ActiveResource::Results

  class << self
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

    # -> http://api.rubyonrails.org/classes/ActiveRecord/ModelSchema/ClassMethods.html#method-i-column_names
    def column_names
      @column_names ||= columns.map(&:name)
    end

    # -> http://api.rubyonrails.org/classes/ActiveRecord/ModelSchema/ClassMethods.html#method-i-columns
    def columns
      @columns ||= self.known_attributes.map { |col| OpenStruct.new(name: col) }
    end

    def find_all(options = {})
      prefix_options, query_options = split_options(options[:params])
      query_options[:limit] = query_options[:per_page]
      path = collection_path(prefix_options, query_options)
      @connection_response = connection.get(path, headers)
      instantiate_collection((format.decode( @connection_response.body ) || []), query_options, prefix_options)
    end

    # -> http://api.rubyonrails.org/classes/ActiveRecord/FinderMethods.html#method-i-find_by
    def find_by(arg, *args)
      arg && arg['id'] ? self.find(arg['id']) : self.find(:first, arg)
    end

    # -> http://api.rubyonrails.org/classes/ActiveRecord/ModelSchema/ClassMethods.html#method-i-inheritance_column
    def inheritance_column
      (@inheritance_column ||= nil) || 'type'
    end

    # -> http://api.rubyonrails.org/classes/ActiveRecord/ModelSchema/ClassMethods.html#method-i-quoted_table_name
    def quoted_table_name
      @quoted_table_name ||= "\"#{self.to_s.tableize}\""
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

    def ransack(params = {}, options = {})
      @ransack_params = params.blank? ? {} : params.permit!.to_h
      OpenStruct.new(conditions: {}, object: OpenStruct.new(klass: self), result: self)
    end

    # -> http://api.rubyonrails.org/classes/ActiveRecord/Reflection/ClassMethods.html#method-i-reflect_on_all_associations
    def reflect_on_all_associations(macro = nil)
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
end

::ActiveResource::Connection.class_eval do
  def quote_column_name(column_name)
    column_name
  end
end
