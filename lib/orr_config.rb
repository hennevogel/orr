module OrrConfig
  HOME_DIR = ENV['HOME'] + '/'
  ORR_DIR = HOME_DIR + '.orr/'
  BIN_DIR = ORR_DIR + 'bin/'
  PROFILE_FILE = HOME_DIR + '.orr_profile'
  GEMRC_FILE = HOME_DIR + ".gemrc"
  BASHRC_FILE = HOME_DIR + '.bashrc'
  ORR_BINARIES = %w( ruby irb gem rake )

  def orr_setup
    # Create what we need on startup
    [ORR_DIR, BIN_DIR].each do |directory|
      Dir.mkdir(directory) unless Dir.exist?(directory)
    end
    edit_bashrc
    edit_gemrc
  end

  private

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
    install_setting = "install: --no-format-executable"

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
end
