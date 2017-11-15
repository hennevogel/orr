class OrrInstallCommand < OrrCommand
  parameter "VERSION ...", "Ruby version", :attribute_name => :ruby_version_arg

  def execute
    ruby_version = ruby_version_arg.first

    unless SUPPORTED.has_key?(DISTRO)
      signal_usage_error "Operating System (#{DISTRO}) not supported. Supported: #{SUPPORTED.keys.join(', ')}"
    end

    puts "Installing ruby#{ruby_version} in #{BIN_DIR}"
    OrrSetup.new.add_repo
    success = shell_command.run_interactive("sudo zypper in -f ruby#{ruby_version}")
    return unless success

    OrrUseCommand.new('').run([ruby_version])
  end
end
