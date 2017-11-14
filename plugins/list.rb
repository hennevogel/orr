class OrrListCommand < OrrCommand
  def execute
    puts "Installed ruby versions:"
    
    rubies = query_system
    rubies.sort.each do |ruby|
      puts "* ruby#{ruby}"
    end
    puts

    puts "Active ruby:"
    ruby_path = shell_command.run("which ruby")
    ruby_rpm = shell_command.run("rpm -qf #{ruby_path}")
    ruby_rpm =~ /^(ruby\d\.\d+)-/
    ruby_name = Regexp.last_match(1)
    ruby_version = shell_command.run("ruby -v")
    puts "* #{ruby_name} (path: #{ruby_path}, version: #{ruby_version})"
  end

  def query_system
    rpms = shell_command.run("rpm -qa ruby\*")
    rubies = []
    rpms.each_line do |rpm|
      if rpm =~ /^ruby(\d.\d+)-\d/
        rubies.push Regexp.last_match(1)
      end
    end
    rubies
  end
end
