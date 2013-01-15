# Encoding: UTF-8

Gem::Specification.new do |s|
  s.author            = ' sunil'
  s.email             ='somee12@hotmail.com'
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-auto_fbposts'
  s.version           = '1.0'
  s.description       = 'Ruby on Rails Auto Fbposts extension for Refinery CMS'
  s.date              = '2013-01-09'
  s.summary           = 'Auto Fbposts extension for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]

  # Runtime dependencies
  s.add_dependency            'refinerycms-core',    '~> 2.0.9'
  s.add_dependency            'refinerycms-settings'
  s.add_dependency            'fb_graph'

  # Development dependencies (usually used for testing)
  s.add_development_dependency 'refinerycms-testing', '~> 2.0.9'
end
