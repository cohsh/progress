require 'fileutils'
require 'gruff'

require_relative './lib/csv_reader'
require_relative './lib/extension_finder'

extensions = get_all_extensions

extensions.each_with_index do |extension, index|
    # Generate a new Gruff object
    g = Gruff::Line.new
    g.title = "Progress about #{extension}"

    # Set CSV file path
    csv_file_path = File.join('.progress', extension, 'lines.csv')

    unless File.exist?(csv_file_path)
        puts "CSV file for #{extension} does not exist. Skip."
        next
    end

    # Read data from csv
    datetimes, line_counts = read_csv_data(csv_file_path)
    
    # Append data
    g.data("# of lines", line_counts)

    # Set labels
    labels = {}
    datetimes.each_with_index { |datetime, i| labels[i] = datetime.strftime('%Y-%m-%d %H:%M') }
    g.labels = labels        

    # Write graph to file
    png_path = File.join('.progress', extension, 'graph.png')
    g.write(png_path)
end