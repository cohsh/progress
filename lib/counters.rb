# Require the 'find' library to traverse directories
require 'find'

# Class to count lines in files within a given directory or file, with or without a certain extension
class LineCounter
  attr_reader :path, :extension

  def initialize(path, extension = nil)
    @path = path
    @extension = extension
  end

  # Counts lines in the specified path
  # If the path is a directory, it counts lines in all files with the specified extension, or all files if no extension is specified.
  # If the path is a file, it counts lines only if the file has the specified extension, or counts for any file if no extension is specified.
  def count_lines
    line_count = 0
    if File.directory?(@path)
      Find.find(@path) do |path|
        if File.file?(path) && (@extension.nil? || @extension.empty? || File.extname(path) == ".#{@extension}")
          line_count += File.readlines(path).size
        end
      end
    elsif File.file?(@path) && (@extension.nil? || @extension.empty? || File.extname(@path) == ".#{@extension}")
      line_count = File.readlines(@path).size
    end
    line_count
  end
end