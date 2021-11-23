$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'mappd/version'

Gem::Specification.new do |s|
  s.name        = 'mappd'
  s.version     = Mappd::VERSION
  s.authors     = ['Dan Watson']
  s.email       = ['dan@paz.am']
  s.homepage    = 'https://github.com/dan-watson/mappd'
  s.summary     = 'Mappd is a micro gem that allow you to write schema
  inside your model as you can do in DataMapper.'
  s.description = 'With it you can add the ability to create columns
outside the default schema, directly in your model in a similar way t
at you just know in others projects like  DataMapper or MongoMapper.
  '.gsub(/^ {4}/, '')

  s.rubyforge_project = 'mappd'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`
                    .split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'activerecord', '~>6.1.4'

  s.required_ruby_version = '>= 2.6.0'
end
