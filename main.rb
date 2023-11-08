require 'date'
require 'fileutils'

# Specify the relative path and read 'counters.rb'
require_relative './lib/counters'
require_relative './lib/extension_finder'

# Get the file path and extension from command line args
file_path = ARGV[0]

extensions = get_all_extensions

extensions.each do |extension|

    # Construct LineCounter instance and execute the count
    counter = LineCounter.new(file_path, extension)
    total_lines = counter.count_lines

    # Prepare the directory path for the progress files
    progress_dir = File.join('.progress', extension)

    # Ensure the directory exists
    FileUtils.mkdir_p(progress_dir)

    # Prepare the file path for writing the data
    progress_file_path = File.join(progress_dir, 'lines.csv')

    puts "#{progress_file_path}"

    # Open the file in append mode and write the datetime and line count
    File.open(progress_file_path, 'a') do |file|
        file.puts "#{DateTime.now},#{total_lines}"
    end

    # Print the result
    puts "Total lines in #{extension.empty? ? "all files" : ".#{extension} files"}: #{total_lines}"

end