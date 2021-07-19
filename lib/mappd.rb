require 'rubygems' unless defined?(Gem)
require 'active_record'
require_relative 'mappd/mappd'

module ActiveRecord
  class Base
    include Mappd
  end
end
