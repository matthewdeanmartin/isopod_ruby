# frozen_string_literal: true

# Rakefile

require 'rake/testtask'
require 'rdoc/task'
require 'bundler/gem_tasks'

# Task to format code using RuboCop
desc 'Format Ruby code'
task :format do
  # echo to console what is happening
  puts 'Running RuboCop with auto-correct...'
  sh 'rubocop -A'
end

# Task to lint code using RuboCop
desc 'Lint Ruby code'
task :lint do
  puts 'Running RuboCop...'
  sh 'rubocop'
end

# Task to run unit tests using Minitest
Rake::TestTask.new do |t|
  puts 'Running Minitest...'
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
  t.warning = true
end

# Task to generate documentation using RDoc
RDoc::Task.new do |rdoc|
  puts 'Generating RDoc documentation...'
  rdoc.rdoc_dir = 'doc'
  rdoc.title = 'Isopod Game Documentation'
  rdoc.options << '--all'
  rdoc.rdoc_files.include('lib/**/*.rb', '*.rb')
end

# Task to create a distributable gem package
task :build do
  puts 'Building gem...'
  sh 'gem build isopod_game.gemspec'
end

# Task to clean generated files
desc 'Clean generated files'
task :clean do
  puts 'Cleaning generated files...'
  sh 'rm -rf doc'
  sh 'rm -f *.gem'
end

# Default task to run all the above tasks
desc 'Run all tasks: format, lint, test, build, and generate docs'
task default: %i[format lint test build rdoc]
