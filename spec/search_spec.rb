require_relative 'test_helper'
require_relative '../plugins/' + File.basename(__FILE__, '_spec.rb')

describe OrrSearchCommand do
  before do
    invocation_path = ""
    @search = OrrSearchCommand.new(invocation_path)
  end

  describe "when executed" do
    it "returns available ruby versions" do
    zypper_out = <<EOT
<?xml version='1.0'?>
<stream>
<message type="info">Loading repository data...</message>
<message type="info">Reading installed packages...</message>

<search-result version="0.0">
<solvable-list>
<solvable status="installed" name="ruby" summary="An Interpreted Object-Oriented Scripting Language" kind="package"/>
<solvable status="installed" name="ruby2.1" summary="An Interpreted Object-Oriented Scripting Language" kind="package"/>
<solvable status="installed" name="ruby2.2" summary="An Interpreted Object-Oriented Scripting Language" kind="package"/>
<solvable status="not-installed" name="ruby2.2" summary="An Interpreted Object-Oriented Scripting Language" kind="srcpackage"/>
<solvable status="not-installed" name="ruby2.3" summary="An Interpreted Object-Oriented Scripting Language" kind="package"/>
<solvable status="not-installed" name="ruby2.3" summary="An Interpreted Object-Oriented Scripting Language" kind="srcpackage"/>
<solvable status="not-installed" name="ruby2.4-rubygem-ffi" summary="Ruby FFI" kind="package"/>
<solvable status="not-installed" name="rubygem-yast-rake" summary="Rake tasks providing basic work-flow for Yast development" kind="srcpackage"/>
</solvable-list>
</search-result>
</stream>
EOT

      mock = Minitest::Mock.new
      mock.expect :run, zypper_out, ["zypper --xml se 'ruby*'"]
      @search.stub :shell_command, mock do
        arguments = []
        assert_output("ruby2.1 (installed)\nruby2.2 (installed)\nruby2.3\n") do
          @search.run(arguments)
        end
      end
    end
  end
end
