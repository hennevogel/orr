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
ruby2.2-rubygem-rack-protection
ruby2.2
ruby2.2-rubygem-rack
ruby2.1
ruby2.2-rubygem-rspec-support
ruby-devel
EOT

      mock = Minitest::Mock.new
      mock.expect :run, rpm_out, ["rpm -qa --qf '%{NAME}\n' ruby\*"]
      mock.expect :run, "/path/to/ruby", ["which ruby"]
      mock.expect :run, "ruby2.2-2.2.5-1.5.x86_64", ["rpm -qf /path/to/ruby"]
      mock.expect :run, "ruby 2.2.5p319 (2016-04-26 revision 54774) [x86_64-linux-gnu]", ["ruby -v"]

      expected_out = <<EOT
Installed ruby versions:
 * 2.1
   2.2

# => - current
# =* - current && default
#  * - default

Active ruby:
* 2.2 (path: /path/to/ruby, version: ruby 2.2.5p319 (2016-04-26 revision 54774) [x86_64-linux-gnu])
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
