require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
require 'mappd'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3',
                                        database: ':memory:')
