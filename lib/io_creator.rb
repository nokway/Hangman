class AcessFile
  attr_accessor :directory, :file

  def initialize
    data_file = '~/Downloads/google-10000-english-no-swears.txt'
    @file = File.open(File.expand_path(data_file), 'r')
  end
  

end

file_obj = AcessFile.new
p file_obj.file.readlines
