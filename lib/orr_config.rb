module OrrConfig
  HOME_DIR = ENV['HOME'] + '/'
  ORR_DIR = HOME_DIR + '.orr/'
  BIN_DIR = ORR_DIR + 'bin/'
  PROFILE_FILE = HOME_DIR + '.orr_profile'
  GEMRC_FILE = HOME_DIR + '.gemrc'
  BASHRC_FILE = HOME_DIR + '.bashrc'
  ORR_BINARIES = %w[ruby irb gem rake].freeze
  OS_RELEASE = OrrSetup.new.osrelease_hash
  DISTRO = OS_RELEASE['NAME'] == 'openSUSE Tumbleweed' ? 'openSUSE_Tumbleweed' : "#{OS_RELEASE['NAME'].tr(' ', '_')}_#{OS_RELEASE['VERSION_ID']}"
  SUPPORTED = { 'openSUSE_Leap_42.1' => '2.1',
                'openSUSE_Leap_42.2' => '2.1',
                'openSUSE_Leap_42.3' => '2.1',
                'openSUSE_Tumbleweed' => '2.4' }.freeze
end
