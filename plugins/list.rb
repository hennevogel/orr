class OrrListCommand < OrrCommand
  def execute
    puts "Installed ruby versions:"
    rpms = shell_command.run("rpm -qa ruby\*")
    rubies = []
    rpms.each_line do |rpm|
      if rpm =~ /^(ruby\d.\d+)-\d/
        rubies.push $1
      end
    end
    rubies.sort.each do |ruby|
      puts "* #{ruby}"
    end
    puts

    puts "Active ruby:"
    ruby_path = shell_command.run("which ruby")
    ruby_rpm = shell_command.run("rpm -qf #{ruby_path}")
    ruby_rpm =~ /^(ruby\d\.\d+)-/
    ruby_name = $1
    ruby_version = shell_command.run("ruby -v")
    puts "* #{ruby_name} (path: #{ruby_path}, version: #{ruby_version})"
  end
end
