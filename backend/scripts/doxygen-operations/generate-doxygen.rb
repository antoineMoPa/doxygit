if ARGV.length == 2
  value = `#{ARGV[0]}`
  puts "Value : " + value
  puts "Exit status : " + $?.exitstatus.to_s
end
