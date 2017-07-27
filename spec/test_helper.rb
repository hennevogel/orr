require 'tmpdir'
# Do not pollute actual directories with our stuff...
tempdir = Dir.mktmpdir("orr-test")
ENV['HOME'] = tempdir

require "minitest/autorun"
require "minitest/stub_const"
require 'pry'
require_relative "../lib/orr.rb"

include OrrConfig
orr_setup

class Minitest::Test
  # After each test...
  def teardown
    # cleanup directories and files
    FileUtils.cd(BIN_DIR) do
       FileUtils.rm_f ORR_BINARIES
    end
    FileUtils.rm_f [GEMRC_FILE, BASHRC_FILE, PROFILE_FILE]
  end
end

# Too new...
#Minitest.after_run {
#  FileUtils.remove_dir tempdir
#}
