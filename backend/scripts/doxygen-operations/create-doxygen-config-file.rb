
#app root dir from config file?

tmp_dir = "/home/doxygit/app/doxygit/backend/tmp"

if !File.directory?(tmp_dir)
  Dir.mkdir(tmp_dir)
end

#cleaning tmp directory
`rm -rf #{tmp_dir}/*`

#creating default config file
`doxygen -g #{tmp_dir}/config`

#storing config options to modify
new_params = Array.new
ARGV.each do |arg|
  new_params.push(arg.scan(/([A-Z_]*)=(.*)/)[0])
end

#loading file in memory and adjusting config values
config_file = ""
File.open("#{tmp_dir}/config", 'r') do |file|
  while line = file.gets
    #if the line isn't a comment
    if line == "\n" || line[0] == "#"
      config_file << "#{line}"
    else
      default_option = line.scan(/(.*)=(.*)/)[0]
      config_file << "#{default_option[0]}="
      
      new_params.each do |option|
        if default_option[0].strip == option[0].to_s.upcase
          #first found is the value assigned
          config_file << " #{option[1]}"
          break
        end
      end

      #if option isn't specified, use default value
      if config_file[-1, 1] == "="
        config_file << "#{default_option[1]}"
      end
    end
  end
end

#updating file
File.open("#{tmp_dir}/config", 'w') do |file|
    file.write(config_file)
end

#TODO set
#input
#recursive yes
#output directory
#javadoc_style
