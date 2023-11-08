require 'set'

# Get extensions in present directory
def get_all_extensions(dir = '.')
extensions = Set.new
Dir.glob("#{dir}/**/*.*") do |file|
    ext = File.extname(file)
    extensions.add(ext) unless ext.empty?
end
extensions.to_a
end