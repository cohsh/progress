require 'find'

class FileStatsCounter
  attr_reader :path, :extension

  def initialize(path, extension = nil)
    @path = path
    @extension = extension
  end

  # Counts lines in the specified path
  def count_lines
    line_count = 0
    process_files do |file|
      line_count += File.readlines(file).size
    end
    line_count
  end

  # Counts the total size of files in the specified path
  def count_file_size
    file_size = 0
    process_files do |file|
      file_size += File.size(file)
    end
    file_size
  end

  private

  # Process files with the given block
  def process_files
    if File.directory?(@path)
      Find.find(@path) do |file|
        if File.file?(file) && extension_match?(file)
          yield(file)
        end
      end
    elsif File.file?(@path) && extension_match?(@path)
      yield(@path)
    end
  end

  # Checks if the file matches the specified extension
  def extension_match?(file_path)
    @extension.nil? || @extension.empty? || File.extname(file_path) == ".#{@extension}"
  end
end