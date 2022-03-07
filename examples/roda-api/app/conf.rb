# frozen_string_literal: true

require 'sqlite3'

db_path = File.expand_path("#{__dir__}/../db/test.db")
DB = Sequel.connect("sqlite://#{db_path}")

DB.extension(:pagination)
Sequel.default_timezone = :utc
Sequel::Model.plugin(:timestamps)
