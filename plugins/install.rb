class OrrInstallCommand < Clamp::Command
  parameter "VERSION ...", "Ruby version", :attribute_name => :ruby_version

  def execute
    puts "Installing ruby#{ruby_version.first}"
  end
end
