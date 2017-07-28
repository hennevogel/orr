module OrrConfig
  HOME_DIR = ENV['HOME'] + '/'
  ORR_DIR = HOME_DIR + '.orr/'
  BIN_DIR = ORR_DIR + 'bin/'
  PROFILE_FILE = HOME_DIR + '.orr_profile'
  GEMRC_FILE = HOME_DIR + '.gemrc'
  BASHRC_FILE = HOME_DIR + '.bashrc'
  ORR_BINARIES = %w[ruby irb gem rake].freeze
  OS_RELEASE = OrrSetup.new.osrelease_hash
  SUPPORTED_OS = %w[openSUSE_42.1 openSUSE_42.2 openSUSE_42.3]
end
