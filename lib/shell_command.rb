class ShellCommand
  def run(command_line)
    `#{command_line}`.chomp
  end

  def run_interactive(command_line)
    system(command_line)
  end
end
