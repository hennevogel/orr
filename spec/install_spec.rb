require_relative 'test_helper'
require_relative '../plugins/' + File.basename(__FILE__, '_spec.rb')

describe OrrInstallCommand do
  before do
    invocation_path = ""
    @cmd = OrrInstallCommand.new(invocation_path)
  end

  describe "when ruby version is not installed yet" do
    it "installs given ruby version" do
      arguments = ["2.3"]
      Dir.mktmpdir("orr-test") do |home_dir|
        bin_dir = Pathname.new(home_dir) + "bin"
        Dir.mkdir(bin_dir)

        bashrc = Pathname.new(home_dir) + ".bashrc"
        bashrc_content = <<EOT
# This is an exemplary .bashrc
PS1='something'
EOT
        File.write(bashrc, bashrc_content)

        env = ENV.to_hash.merge("HOME" => home_dir)

        mock = Minitest::Mock.new
        mock.expect :run_interactive, nil, ["sudo zypper in ruby2.3"]

        @cmd.stub :shell_command, mock do
          assert_output(/^Installing ruby2.3 in #{bin_dir}\n/) do
            Object.stub_const(:ENV, env) do
              @cmd.run(arguments)
            end
          end
        end
        assert_equal("/usr/bin/ruby.ruby2.3", File.readlink(bin_dir + "ruby"))
        assert_equal("/usr/bin/irb.ruby2.3", File.readlink(bin_dir + "irb"))
        assert_equal("/usr/bin/gem.ruby2.3", File.readlink(bin_dir + "gem"))
        assert_equal("/usr/bin/rake.ruby2.3", File.readlink(bin_dir + "rake"))

        expected_bashrc_content = bashrc_content + <<EOT
export GEM_HOME=~/.gems/ruby2.3
export PATH=$GEM_HOME/bin:$PATH
EOT
        assert_equal(expected_bashrc_content, File.read(bashrc))

        expected_gemrc_content = <<EOT
install: --no-format-executable
EOT
        assert_equal(expected_gemrc_content, File.read(Pathname.new(home_dir) + ".gemrc"))
      end
    end
  end

  describe "when ruby version is already installed" do
    it "installs given ruby version" do
      arguments = ["2.3"]
      Dir.mktmpdir("orr-test") do |home_dir|
        bin_dir = Pathname.new(home_dir) + "bin"
        Dir.mkdir(bin_dir)
        ["ruby", "irb", "gem", "rake"].each do |cmd|
          File.symlink("/usr/bin/#{cmd}.ruby2.2", bin_dir + cmd)
        end

        bashrc = Pathname.new(home_dir) + ".bashrc"
        bashrc_content = <<EOT
# This is an exemplary .bashrc
PS1='something'
export GEM_HOME=~/.gems/ruby2.2
export PATH=$GEM_HOME/bin:$PATH
# something else
EOT
        File.write(bashrc, bashrc_content)

        gemrc_content = <<EOT
install: --no-format-executable
EOT
        File.write(Pathname(home_dir) + ".gemrc", gemrc_content)

        env = ENV.to_hash.merge("HOME" => home_dir)

        mock = Minitest::Mock.new
        mock.expect :run_interactive, nil, ["sudo zypper in ruby2.3"]

        @cmd.stub :shell_command, mock do
          assert_output(/^Installing ruby2.3 in #{bin_dir}\n/) do
            Object.stub_const(:ENV, env) do
              @cmd.run(arguments)
            end
          end
        end
        assert_equal("/usr/bin/ruby.ruby2.3", File.readlink(bin_dir + "ruby"))
        assert_equal("/usr/bin/irb.ruby2.3", File.readlink(bin_dir + "irb"))
        assert_equal("/usr/bin/gem.ruby2.3", File.readlink(bin_dir + "gem"))
        assert_equal("/usr/bin/rake.ruby2.3", File.readlink(bin_dir + "rake"))

        expected_bashrc_content = <<EOT
# This is an exemplary .bashrc
PS1='something'
export GEM_HOME=~/.gems/ruby2.3
export PATH=$GEM_HOME/bin:$PATH
# something else
EOT
        assert_equal(expected_bashrc_content, File.read(bashrc))

        expected_gemrc_content = <<EOT
install: --no-format-executable
EOT
        assert_equal(expected_gemrc_content, File.read(Pathname.new(home_dir) + ".gemrc"))
      end
    end
  end
end
