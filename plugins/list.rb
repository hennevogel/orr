class OrrListCommand < OrrCommand
  def execute
    puts "Installed ruby versions:"
    
    rubies = query_system
    rubies.sort.each do |ruby|
      puts "#{version_marker(ruby)} #{ruby}"
    end
    puts
    puts '# => - current'
    puts '# =* - current && default'
    puts '#  * - default'
    puts

    puts "Active ruby:"
    ruby_path = shell_command.run("which ruby")
    ruby_rpm = shell_command.run("rpm -qf #{ruby_path}")
    ruby_rpm =~ /^ruby(\d\.\d+)-/
    ruby_name = Regexp.last_match(1)
    ruby_version = shell_command.run("ruby -v")
    puts "* #{ruby_name} (path: #{ruby_path}, version: #{ruby_version})"
  end

  def query_system
    rpms = shell_command.run("rpm -qa --qf '%{NAME}\n' ruby\*")
    rubies = []
    rpms.each_line do |rpm|
      if rpm =~ /^ruby(\d.\d+)$/
        rubies.push Regexp.last_match(1)
      end
    end
    rubies
  end
  def version_marker(ruby_version)
    return "=*" if ENV['ORR_RUBY'] == ruby_version && SUPPORTED[DISTRO] == ruby_version
    return ' *' if ENV['ORR_RUBY'] != ruby_version && SUPPORTED[DISTRO] == ruby_version
    return '=>' if ENV['ORR_RUBY'] == ruby_version
    return '  '
  end
end
