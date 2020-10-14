# frozen_string_literal: true

require 'active_admin'
require_relative 'base'
require_relative 'connection'

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
