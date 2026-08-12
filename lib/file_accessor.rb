require_relative 'reader_class'

class FileAccessor
  attr_accessor :directory, :file

  def initialize
    @file = ''
  end

  def access_file
    data_file = '~/Downloads/google-10000-english-no-swears.txt'
    @file = File.open(File.expand_path(data_file), 'r')
  end

  def close_file
    file.close
  end
end
