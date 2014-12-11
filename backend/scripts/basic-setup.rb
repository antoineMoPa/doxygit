
if ARGV[0].nil?
  puts "The first argument is the temp directory's unique id"
  exit
end

ENV['DOXYGIT_TMP'] = ARGV[0]

conifg_setup = "doxygen-operations/create-doxygen-config-file.rb"

out = `ruby #{config_setup} input=/path/to/input`

if $?.exitstatus != 0
  exit 1
end

puts out
