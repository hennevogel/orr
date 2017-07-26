require 'rake/testtask'

IMAGE_USERID=`id -u`

desc 'Put on your boots and take your development environment to town!'
task :suitup do
  sh "docker build . -t hennevogel/orr:dev --build-arg IMAGE_USERID=#{IMAGE_USERID} -f Dockerfile.dev"
  sh "docker run -it hennevogel/orr:dev"
end

desc 'Rebuild our docker images and publish them'
task :rebuild_images do
  sh "docker build . -t hennevogel/orr:422 -t hennevogel/orr:latest -f Dockerfile.422"
  sh "docker build . -t hennevogel/orr:421 -f Dockerfile.421"
  sh "docker push hennevogel/orr:422"
  sh "docker push hennevogel/orr:421"
end

Rake::TestTask.new do |t|
  t.pattern = "spec/*_spec.rb"
end
