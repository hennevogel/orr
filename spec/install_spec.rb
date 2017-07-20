require_relative 'test_helper'
require_relative '../plugins/' + File.basename(__FILE__, '_spec.rb')

describe OrrInstallCommand do
  before do
    invocation_path = ""
    @cmd = OrrInstallCommand.new(invocation_path)
  end

  describe "when executed" do
    it "installs given ruby version" do
      arguments = ["2.3"]
      assert_output("Installing ruby2.3\n") {
        @cmd.run(arguments)
      }
    end
  end
end
