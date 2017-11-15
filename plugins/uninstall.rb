class OrrUninstallCommand < OrrCommand
  parameter "VERSION ...", "Ruby version", :attribute_name => :ruby_version_arg
  def execute
    ruby_version = ruby_version_arg.first

    unless SUPPORTED.has_key?(DISTRO)
      signal_usage_error "Operating System (#{DISTRO}) not supported. Supported: #{SUPPORTED.keys.join(', ')}"
    end

    if ruby_version ==  SUPPORTED[DISTRO]
      signal_usage_error "You can not remove the default ruby. To remove orr: orr implode --help"
    end

    puts "Removing ruby#{ruby_version} from #{BIN_DIR}"
    OrrSetup.new.add_repo
    success = shell_command.run_interactive("sudo zypper rm ruby#{ruby_version}")
    return unless success

    puts "Switching to default ruby #{SUPPORTED[DISTRO]}"
    OrrUseCommand.new('').run([SUPPORTED[DISTRO]])
  end
end
