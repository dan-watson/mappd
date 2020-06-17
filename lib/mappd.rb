require 'rubygems' unless defined?(Gem)
require 'active_record'
require 'mappd/mappd'

module ActiveRecord
  class Base
    include Mappd
  end
end
