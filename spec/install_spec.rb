require_relative 'test_helper'
require_relative '../plugins/' + File.basename(__FILE__, '_spec.rb')

describe OrrInstallCommand do
  before do
    invocation_path = ""
    @cmd = OrrInstallCommand.new(invocation_path)
  end

  describe "when ruby version is not installed yet" do
    before do
      @expected_profile_content = <<EOT
export GEM_HOME=~/.gems/ruby2.3
export PATH=$GEM_HOME/bin:$PATH
EOT
    end
    it "installs given ruby version" do
      arguments = ["2.3"]
      mock = Minitest::Mock.new
      mock.expect :run_interactive, nil, ["sudo zypper in ruby2.3"]

      @cmd.stub :shell_command, mock do
        assert_output(/^Installing ruby2.3 in #{BIN_DIR}\n/) do
          @cmd.run(arguments)
        end
      end

      ORR_BINARIES.each do |cmd|
        assert_equal("/usr/bin/#{cmd}.ruby2.3", File.readlink(BIN_DIR + cmd))
      end

      assert_equal(@expected_profile_content, File.read(PROFILE_FILE))
    end
  end

  describe "when ruby version is already installed" do
    before do
      ORR_BINARIES.each do |cmd|
        File.symlink("/usr/bin/#{cmd}.ruby2.2", BIN_DIR + cmd)
      end
      @expected_profile_content = <<EOT
export GEM_HOME=~/.gems/ruby2.4
export PATH=$GEM_HOME/bin:$PATH
EOT
    end

    it "installs given ruby version" do
      arguments = ["2.4"]
      mock = Minitest::Mock.new
      mock.expect :run_interactive, nil, ["sudo zypper in ruby2.4"]

      @cmd.stub :shell_command, mock do
        assert_output(/^Installing ruby2.4 in #{BIN_DIR}\n/) do
          @cmd.run(arguments)
        end
      end

      ORR_BINARIES.each do |cmd|
        assert_equal("/usr/bin/#{cmd}.ruby2.4", File.readlink(BIN_DIR + cmd))
      end

      assert_equal(@expected_profile_content, File.read(PROFILE_FILE))
    end
  end
end
