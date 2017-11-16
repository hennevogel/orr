require_relative 'test_helper'
require_relative '../plugins/' + File.basename(__FILE__, '_spec.rb')
require 'fileutils'

describe OrrUseCommand do
  describe "when ruby version used" do
    before do
      @cmd = OrrUseCommand.new('')

      ORR_BINARIES.each do |cmd|
        File.symlink("/usr/bin/#{cmd}.ruby2.2", "#{BIN_DIR}/#{cmd}")
      end
      FileUtils.rm_f(PROFILE_FILE)
      @expected_profile_content = <<EOT
export GEM_HOME=~/.gems/ruby2.5
export PATH=#{BIN_DIR}:$GEM_HOME/bin:$PATH
EOT
    end

    it "uses given ruby version" do
      list_command = MiniTest::Mock.new
      list_command.expect :query_system, ['2.5']
      OrrListCommand.stub :new, list_command do
        @cmd.run(['2.5'])
      end
      ORR_BINARIES.each do |cmd|
        assert_equal("/usr/bin/#{cmd}.ruby2.5", File.readlink("#{BIN_DIR}/#{cmd}"))
      end

      assert_equal(@expected_profile_content, File.read(PROFILE_FILE))
    end
  end
end
