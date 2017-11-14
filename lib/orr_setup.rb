class OrrSetup
  def setup
    # Create what we need on startup
    [ORR_DIR, BIN_DIR].each do |directory|
      Dir.mkdir(directory) unless Dir.exist?(directory)
    end
    edit_bashrc
    edit_gemrc
  end

  # FIXME: /etc/profile.d is the place to do this in general, for all shells
  def edit_bashrc
    profile_setting = 'test -s ~/.orr_profile && . ~/.orr_profile || true'

    found_profile_setting = false
    if File.exist?(BASHRC_FILE)
      BASHRC_FILE.each_line do |line|
        found_profile_setting = true if line.chomp == profile_setting
      end
    end

    File.open(BASHRC_FILE, 'a') do |f|
      f.puts(profile_setting) unless found_profile_setting
    end
  end

  def edit_gemrc
    install_setting = 'install: --no-format-executable'

    found_install_setting = false
    if File.exist?(GEMRC_FILE)
      GEMRC_FILE.each_line do |line|
        found_install_setting = true if line.chomp == install_setting
      end
    end

    File.open(GEMRC_FILE, 'a') do |f|
      f.puts(install_setting) unless found_install_setting
    end
  end

  def osrelease_hash
    osrelease = {}
    File.open('/etc/os-release', 'r') do |f|
      f.each_line do |line|
        osrelease_a = line.split('=')
        osrelease[osrelease_a[0]] = osrelease_a[1].chomp.gsub!(/\A"|"\Z/, '')
      end
    end
    return osrelease
  end

  def add_repo
    distro = "#{OS_RELEASE['NAME'].tr(' ', '_')}_#{OS_RELEASE['VERSION_ID']}"
    distro = 'openSUSE_Tumbleweed' if OS_RELEASE['NAME'] == 'openSUSE Tumbleweed'
    unless SUPPORTED_OS.include?(distro)
      puts "Operating System (#{distro}) not supported"
      return false
    end

    repo_url = "http://download.opensuse.org/repositories/devel:/languages:/ruby/#{distro}"
    shell_command.run("grep -q \'baseurl=#{repo_url}\' /etc/zypp/repos.d/*")
    shell_command.run_interactive("sudo zypper ar -f #{repo_url}/devel:languages:ruby.repo") unless $?.exitstatus == 0
  end

  def shell_command
    ShellCommand.new
  end
end
