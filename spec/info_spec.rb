require_relative 'test_helper'
require_relative '../plugins/' + File.basename(__FILE__, '_spec.rb')

describe OrrInfoCommand do
  before do
    @info = OrrInfoCommand.new
  end

  describe "when executed" do
    it "must respond" do
      @info.run.must_equal "OHAI!"
    end
  end

end
