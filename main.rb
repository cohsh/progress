# Specify the relative path and read 'counters.rb'
require_relative './lib/counters'

# Get the file path and extension from command line args
file_path = ARGV[0]
extension = ARGV[1] || '' # If the extension not exists, the empty value is set.

# Construct LineCounter instance and execute the count
counter = LineCounter.new(file_path, extension)
total_lines = counter.count_lines

# Print the result
puts "Total lines in #{extension.empty? ? "all files" : ".#{extension} files"}: #{total_lines}"