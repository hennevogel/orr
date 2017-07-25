class OrrInfoCommand < OrrCommand
  def execute
    uname_output = `uname -a`.gsub("\n", '')
    get_bash_info
    orr_info = <<-EOT

system:

  system:
    uname:        "#{uname_output}"
    architecture: "#{RbConfig::CONFIG['target_cpu']}"
    bash:         "#{@bash_path} => #{@bash_version}"

  binaries:
    ruby:         "#{get_executable("ruby")}"
    irb:          "#{get_executable("irb")}"
    gem:          "#{get_executable("gem")}"
    rake:         "#{get_executable("rake")}"

  environment:
    PATH:         "#{ENV['PATH']}"
    GEM_HOME:     "#{ENV['GEM_HOME']}"

EOT
    puts orr_info
  end

  def get_bash_info
    @bash_path = `which bash`.gsub("\n", '')
    @bash_version = `bash --version|head -n1`.gsub("\n", '') if !@bash_path.empty?
    @bash_version = "not installed" if @bash_path.empty?
  end

  def get_executable(command)
    shell_command.run("which #{command}")
  end
end
