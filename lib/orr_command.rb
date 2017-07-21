class OrrCommand < Clamp::Command
  def shell_command
    ShellCommand.new
  end
end
