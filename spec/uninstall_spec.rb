require_relative 'test_helper'
require_relative '../plugins/' + File.basename(__FILE__, '_spec.rb')

describe OrrUninstallCommand do
  before do
    @cmd = OrrUninstallCommand.new("")
  end

  describe "when not default version" do
    before do
      ORR_BINARIES.each do |cmd|
        File.symlink("/usr/bin/#{cmd}.ruby2.2", BIN_DIR + cmd)
      end
      @expected_profile_content = <<EOT
export GEM_HOME=~/.gems/ruby2.1
export PATH=#{BIN_DIR}:$GEM_HOME/bin:$PATH
EOT
    end

    it "removes given ruby version" do
      list_command = MiniTest::Mock.new
      list_command.expect :query_system, ['2.1']
      OrrListCommand.stub :new, list_command do
        mock = Minitest::Mock.new
        mock.expect :run_interactive, true, ["sudo zypper rm ruby2.4"]
        @cmd.stub :shell_command, mock do
          assert_output(/^Removing ruby2.4 from #{BIN_DIR}\n/) do
            @cmd.run(["2.4"])
          end
        end
      end

      ORR_BINARIES.each do |cmd|
        assert_equal("/usr/bin/#{cmd}.ruby2.1", File.readlink(BIN_DIR + cmd))
      end

      assert_equal(@expected_profile_content, File.read(PROFILE_FILE))
    end
  end
end
