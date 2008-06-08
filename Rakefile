require 'rubygems'
require 'rake/gempackagetask'

GEM = "logbot"
VERSION = "0.0.1"
AUTHOR = "David Leal"
EMAIL = "dgleal@gmail.com"
HOMEPAGE = ""
SUMMARY = "An IRC logger bot"

spec = Gem::Specification.new do |s|
  s.name = GEM
  s.version = VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE", 'TODO']
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  
  # Uncomment this to add a dependency
  s.add_dependency "minibot"
  s.add_dependency "dm-core"
  
  s.require_path = 'lib'
  s.autorequire = GEM
  s.files = %w(LICENSE README Rakefile TODO) + Dir.glob("{lib,specs}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

task :install => [:package] do
  sh %{sudo gem install pkg/#{GEM}-#{VERSION}}
end
