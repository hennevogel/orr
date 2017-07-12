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
  end

end
