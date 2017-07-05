require 'rake/testtask'

IMAGE_USERID=`id -u`

desc 'Put on your boots and take your development environment to town!'
task :suitup do
  sh "docker build . -t hennevogel/orr:latest -t hennevogel/orr:dev --build-arg IMAGE_USERID=#{IMAGE_USERID}"
  sh "docker run -it hennevogel/orr:dev"
end

task :test do
  puts 'God you are boring...'
  Rake::Task["ohno"].invoke
end

Rake::TestTask.new do |t|
  t.pattern = "spec/*_spec.rb"
  t.name = :ohno
  t.description = 'Let the test suite yell at you for being a useless plonker'
end
