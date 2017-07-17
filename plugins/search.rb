require_relative "../lib/shell_command"
require "rexml/document"

class OrrSearchCommand < Clamp::Command
  def execute
    rubies = []

    xml = shell_command.run("zypper --xml se 'ruby*'")
    doc = REXML::Document.new(xml)
    doc.elements.each("stream/search-result/solvable-list/solvable") do |element|
      name = element.attributes["name"]
      status = element.attributes["status"]
      kind = element.attributes["kind"]
      if name =~ /^ruby\d\.\d+$/ && kind == "package"
        ruby = name
        ruby += " (installed)" if status == "installed"
        rubies.push(ruby)
      end
    end

    puts rubies.join("\n")
  end

  def shell_command
    ShellCommand.new
  end
end
