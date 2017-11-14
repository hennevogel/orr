class OrrUseCommand < OrrCommand
  parameter "VERSION ...", "Ruby version", :attribute_name => :ruby_version_arg, :required => true

  def execute
    ruby_version = ruby_version_arg.first

    FileUtils.cd(BIN_DIR) do
      FileUtils.rm_f ORR_BINARIES
    end
    ORR_BINARIES.each do |cmd|
      File.symlink("/usr/bin/#{cmd}.ruby#{ruby_version}", BIN_DIR + cmd)
    end

    replace_profile(ruby_version)
    puts "Make sure to restart your shell to make new GEM_HOME and PATH settings active"
  end

  def replace_profile(ruby_version)
    export_gem_home = "export GEM_HOME=~/.gems/ruby#{ruby_version}"
    export_path = "export PATH=#{BIN_DIR}:$GEM_HOME/bin:$PATH"

    File.open(PROFILE_FILE, 'w') do |f|
      f.puts(export_gem_home)
      f.puts(export_path)
    end
  end
end
