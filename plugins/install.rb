class OrrInstallCommand < OrrCommand
  parameter "VERSION ...", "Ruby version", :attribute_name => :ruby_version_arg

  def home_dir
    Pathname(ENV["HOME"])
  end

  def execute
    ruby_version = ruby_version_arg.first
    bin_dir = home_dir + "bin"

    puts "Installing ruby#{ruby_version} in #{bin_dir}"

    shell_command.run_interactive("sudo zypper in ruby#{ruby_version}")

    ["ruby", "irb", "gem", "rake"].each do |cmd|
      if File.exist?(bin_dir + cmd)
        File.delete(bin_dir + cmd)
      end
      File.symlink("/usr/bin/#{cmd}.ruby#{ruby_version}", bin_dir + cmd)
    end

    edit_bashrc(ruby_version)
    edit_gemrc

    puts "Make sure to restart your shell to make new GEM_HOME and PATH settings active"
  end

  def edit_bashrc(ruby_version)
    bashrc = home_dir + ".bashrc"

    export_gem_home = "export GEM_HOME=~/.gems/ruby#{ruby_version}\n"
    export_path = "export PATH=$GEM_HOME/bin:$PATH\n"

    bashrc_out = ""
    found_home = false
    found_path = false
    bashrc.each_line do |line|
      if line =~ /^export GEM_HOME=/
        bashrc_out += export_gem_home
        found_home = true
      elsif line =~ /^export PATH=\$GEM_HOME\/bin:\$PATH/
        bashrc_out += line
        found_path = true
      else
        bashrc_out += line
      end
    end
    if !found_home
      bashrc_out += export_gem_home
    end
    if !found_path
      bashrc_out += export_path
    end

    File.write(bashrc, bashrc_out)
  end

  def edit_gemrc
    gemrc = home_dir + ".gemrc"

    install_setting = "install: --no-format-executable"

    gemrc_out = ""
    found_install_setting = false
    if File.exist?(gemrc)
      gemrc.each_line do |line|
        if line.chomp == install_setting
          found_install_setting = true
        end
        gemrc_out += line
      end
    end
    if !found_install_setting
      gemrc_out += install_setting + "\n"
    end

    File.write(gemrc, gemrc_out)
  end
end
