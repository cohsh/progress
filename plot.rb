#!/usr/bin/env ruby
require 'fileutils'
require 'gruff'

require_relative './lib/csv_reader'
require_relative './lib/extension_finder'

extensions = get_all_extensions

stats_to_count = ['lines', 'size']

stats_to_count.each do |stat|
    extensions.each_with_index do |extension, index|
        # Generate a new Gruff object
        g = Gruff::Line.new
        g.title = "Progress about #{extension}"

        # Set CSV file path
        csv_file_path = File.join('.progress', extension, "#{stat}.csv")

        unless File.exist?(csv_file_path)
            puts "CSV file for #{extension} does not exist. Skip."
            next
        end

        # Read data from csv
        datetimes, line_counts = read_csv_data(csv_file_path)
        
        # Append data
        g.data("# of #{stat}", line_counts)

        # Set labels
        labels = {}
        datetimes.each_with_index { |datetime, i| labels[i] = datetime.strftime('%m/%d') }
        g.labels = labels        

        # Make graph directory
        graph_directory = File.join('.progress', extension, 'graphs')
        FileUtils.mkdir_p(graph_directory)

        # Write graph to file
        png_path = File.join(graph_directory, "#{stat}.png")
        g.write(png_path)
    end
end