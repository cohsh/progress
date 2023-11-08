require 'gruff'
require 'csv'
require 'date'

# Get the csv file path from command line arg
csv_file_path = ARGV[0]

# Read DateTime and lines from CSV
def read_csv_data(csv_file)
    datetimes = []
    line_counts = []

    CSV.foreach(csv_file, headers: false) do |row|
        # Access each element
        datetime_str = row[0]
        line_count_str = row[1]

        # Skip nil or empty data
        next if datetime_str.nil? || datetime_str.strip.empty?
        next if line_count_str.nil? || line_count_str.strip.empty?

        # Add DateTime and lines to array
        datetimes << DateTime.parse(datetime_str)
        line_counts << line_count_str.to_i
    end

    return datetimes, line_counts
end

# Create graph
def create_graph(datetimes, line_counts)
    # Generate a new Gruff object
    g = Gruff::Line.new
    g.title = '行数の時間経過'

    # Append data
    g.data('行数', line_counts)

    # Set labels
    labels = {}
    datetimes.each_with_index { |datetime, index| labels[index] = datetime.strftime('%Y-%m-%d %H:%M') }
    g.labels = labels

    # Write graph to file
    g.write('line_counts_graph.png')
end

# Read data from csv
datetimes, line_counts = read_csv_data(csv_file_path)

# Create graph
create_graph(datetimes, line_counts)