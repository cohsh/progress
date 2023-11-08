require 'date'
require 'csv'

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