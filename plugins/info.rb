class OrrInfoCommand < OrrCommand
  def execute
    uname_output = `uname -a`.gsub("\n", '')
    get_bash_info
    orr_info = <<-EOT

system:

  system:
    uname:        "#{uname_output}"
    name:         "openSUSE"
    version:      "42.2"
    architecture: "#{RbConfig::CONFIG['target_cpu']}"
    bash:         "#{@bash_path} => #{@bash_version}"
    zsh:          "#{@zsh_path} => #{@zsh_version}"

  orr:
    version:      "0.1"
    path:         "/home/vagrant/.rvm"
    autolibs:     "[4] Allow RVM to use package manager if found, install missing dependencies, install package manager (only OS X)."

  homes:
    gem:          "not set"
    ruby:         "not set"

  binaries:
    ruby:         "#{get_executable("ruby")}"
    irb:          "#{get_executable("irb")}"
    gem:          "#{get_executable("gem")}"
    rake:         "#{get_executable("rake")}"

  environment:
    PATH:         "/home/vagrant/bin:/usr/local/bin:/usr/bin:/bin:/usr/games:/home/vagrant/.rvm/bin"
    GEM_HOME:     ""
    GEM_PATH:     ""
    MY_RUBY_HOME: ""
    IRBRC:        ""
    RUBYOPT:      ""
    gemset:       ""

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
