class ShellCommand
  def run(command_line)
    `#{command_line}`.chomp
  end
end
