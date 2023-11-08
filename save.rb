require 'date'
require 'fileutils'

# Specify the relative path and read 'counters.rb'
require_relative './lib/counters'
require_relative './lib/extension_finder'

# Get the file path from command line args or set to current directory if not provided
file_path = ARGV[0]
file_path = '.' if file_path.nil? || file_path.empty?

extensions = get_all_extensions

extensions.each do |extension|

    # Construct LineCounter instance and execute the count
    counter = FileStatsCounter.new(file_path, extension)
    total_lines = counter.count_lines
    total_file_size = counter.count_file_size

    # Prepare the directory path for the progress files
    progress_dir = File.join('.progress', extension)

    # Ensure the directory exists
    FileUtils.mkdir_p(progress_dir)

    # Prepare the file path for writing the data
    lines_progress_file_path = File.join(progress_dir, 'lines.csv')
    size_progress_file_path = File.join(progress_dir, 'size.csv')

    # Open the file in append mode and write the datetime and data
    File.open(lines_progress_file_path, 'a') do |file|
        file.puts "#{DateTime.now},#{total_lines}"
    end

    File.open(size_progress_file_path, 'a') do |file|
        file.puts "#{DateTime.now},#{total_file_size}"
    end

    # Print the result
    puts "Total lines in #{extension.empty? ? "all files" : ".#{extension} files"}: #{total_lines}"
    puts "Total lines in #{extension.empty? ? "all size" : ".#{extension} byte"}: #{total_file_size}"

end