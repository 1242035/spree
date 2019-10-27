require 'thor'
require 'thor/group'

case ARGV.first
when 'version', '-v', '--version'
  puts Gem.loaded_specs['viauco_cmd'].version
when 'extension'
  ARGV.shift
  require 'viauco_cmd/extension'
  ViaucoCmd::Extension.start
end
