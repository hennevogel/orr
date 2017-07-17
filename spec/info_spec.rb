require_relative 'test_helper'
require_relative '../plugins/' + File.basename(__FILE__, '_spec.rb')

describe OrrInfoCommand do
  before do
    invocation_path = ""
    @info = OrrInfoCommand.new(invocation_path)
  end

  describe "when executed" do
    it "must respond" do
      arguments = []
      assert_output(/system:/) {
        @info.run(arguments)
      }
    end

    it "returns ruby path" do
      mock = Minitest::Mock.new
      mock.expect :run, "/path/to/ruby", ["which ruby"]
      mock.expect :run, "/path/to/irb", ["which irb"]
      mock.expect :run, "/path/to/gem", ["which gem"]
      mock.expect :run, "/path/to/rake", ["which rake"]
      @info.stub :shell_command, mock do
        arguments = []
        assert_output(/ruby:\s*"\/path\/to\/ruby/) {
          @info.run(arguments)
        }
      end
    end
  end
end
