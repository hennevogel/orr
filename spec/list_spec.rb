require_relative 'test_helper'
require_relative '../plugins/' + File.basename(__FILE__, '_spec.rb')

describe OrrInfoCommand do
  before do
    invocation_path = ""
    @info = OrrListCommand.new(invocation_path)
  end

  describe "when executed" do
    it "lists installed and active ruby versions" do
      rpm_out = <<EOT
libruby2_2-2_2-2.2.5-1.5.x86_64
ruby2.2-rubygem-rack-protection-1.5.3-4.1.x86_64
ruby2.2-2.2.5-1.5.x86_64
ruby2.2-rubygem-rack-1.6.4-22.21.x86_64
ruby2.1-2.1.9-1.1.x86_64
ruby2.2-rubygem-rspec-support-3.5.0-1.1.x86_64
ruby-devel-2.2-1.3.x86_64
EOT

      mock = Minitest::Mock.new
      mock.expect :run, rpm_out, ["rpm -qa ruby\*"]
      mock.expect :run, "/path/to/ruby", ["which ruby"]
      mock.expect :run, "ruby2.2-2.2.5-1.5.x86_64", ["rpm -qf /path/to/ruby"]
      mock.expect :run, "ruby 2.2.5p319 (2016-04-26 revision 54774) [x86_64-linux-gnu]", ["ruby -v"]

      expected_out = <<EOT
Installed ruby versions:
* ruby2.1
* ruby2.2

Active ruby:
* ruby2.2 (path: /path/to/ruby, version: ruby 2.2.5p319 (2016-04-26 revision 54774) [x86_64-linux-gnu])
EOT

      @info.stub :shell_command, mock do
        arguments = []
        assert_output(expected_out) {
          @info.run(arguments)
        }
      end
    end
  end
end
