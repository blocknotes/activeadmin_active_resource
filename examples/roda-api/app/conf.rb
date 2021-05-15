# frozen_string_literal: true

require 'sqlite3'

DB = Sequel.connect('sqlite://db/test.db')

DB.extension(:pagination)
Sequel.default_timezone = :utc
Sequel::Model.plugin(:timestamps)
