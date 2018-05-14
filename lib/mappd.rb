require 'rubygems' unless defined?(Gem)
require 'active_record'
require 'mappd/mappd'

ActiveRecord::Base.send(:include, Mappd)
