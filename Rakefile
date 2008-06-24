require 'rubygems'
require 'rake/gempackagetask'
require 'spec/rake/spectask'

load 'logbot.gemspec'

Rake::GemPackageTask.new(SPEC) do |pkg|
  pkg.gem_spec = SPEC
end

task :install => [:package] do
  sh %{sudo gem install pkg/#{GEM}-#{VERSION}}
end

desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*.rb']
  t.spec_opts = %w{--color}
end

desc "Run all specs with rcov"
Spec::Rake::SpecTask.new('spec:rcov') do |t|
  t.spec_files = FileList['spec/**/*.rb']
  t.rcov = true
  t.rcov_opts = %w{--exclude spec --text-summary}
end
