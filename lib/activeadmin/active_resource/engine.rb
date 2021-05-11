# frozen_string_literal: true

require 'active_admin'
require 'active_resource'

require_relative 'base'
require_relative 'connection'
require_relative 'results'

module ActiveAdmin
  module ActiveResource
    class Engine < ::Rails::Engine
      engine_name 'activeadmin_active_resource'
    end
  end
end

::ActiveResource::Base.class_eval do
  prepend ActiveAdmin::ActiveResource::Base
end

::ActiveResource::Connection.class_eval do
  prepend ActiveAdmin::ActiveResource::Connection
end
