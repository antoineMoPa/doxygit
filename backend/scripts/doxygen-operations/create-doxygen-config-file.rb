#TODO app root dir from environnement variable?
#     generate without comments
#     unique directory per request

require 'fileutils'

#root = ENV['DOXYGIT_ROOT']
tmp_dir = "/home/doxygit/backend/tmp"

#trying to create tmp directory if missing
if !File.directory?(tmp_dir)
  FileUtils.mkdir_p tmp_dir
end

Dir.chdir tmp_dir

#cleaning tmp directory
FileUtils.rm_rf(Dir.glob('*'))

#creating default config file
`doxygen -g config`

#storing config options to modify
new_options = Array.new
ARGV.each do |arg|
  new_options.push(arg.scan(/([A-Za-z_]*)=(.*)/)[0])
end

#loading file in memory and adjusting config values
config_file = ""
File.open("config", 'r') do |file|
  while line = file.gets
    #if the line is a comment or empty
    if line == "\n" || line[0] == "#"
      config_file << line
    else
      default_option = line.scan(/(.*)=(.*)/)[0]
      config_file << "#{default_option[0]}="

      #looking for new requested option match
      new_options.each do |option|
        if default_option[0].strip == option[0].to_s.upcase
          #first found is the value assigned
          config_file << " #{option[1]}\n"
          break
        end
      end

      #if option isn't specified, use default value
      if config_file[-1, 1] == "="
        config_file << default_option[1] << "\n"
      end
    end
  end
end

#updating file
File.open("config", 'w') do |file|
    file.write(config_file)
end
