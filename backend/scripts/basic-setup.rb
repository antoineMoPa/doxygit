
if ARGV[0].nil? || ARGV[1].nil?
  puts "Required arguments are a unique id and a git repo url"
  exit 1
end

ENV['DOXYGIT_SHORTID'] = ARGV[0]
url = ARGV[1]

config_setup = "scripts/doxygen-operations/create-doxygen-config-file.rb"
git_fetch = "scripts/git-operations/fetch-from-git.rb"
#create_documentation = "doxygen-operations/"
#move documentation?

out = `ruby #{config_setup} output_directory=../www/data/#{ENV['DOXYGIT_SHORTID']} "html_output=./" input=tmp/#{ENV['DOXYGIT_SHORTID']}/source generate_latex=NO`

if $?.exitstatus != 0
  exit 1
end

puts out

out = `ruby #{git_fetch} #{url}`

if $?.exitstatus != 0
  exit 1
end

puts out

puts `doxygen tmp/#{ENV['DOXYGIT_SHORTID']}/config`
