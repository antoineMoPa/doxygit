
#checking proper configuration
if ENV['DOXYGIT_SHORTID'].nil?
  puts "Environnement variable DOXYGIT_SHORTID must be set."
  exit 1
end

if ARGV[0].nil?
  puts "Repo url expected as first argument"
  exit 1
end

out = `git clone #{ARGV[0]} tmp/#{ENV['DOXYGIT_SHORTID']}/source`
