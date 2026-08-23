class FileAccessor
  attr_accessor :directory, :file, :array, :json_file

  def initialize
    @file = ''
    @array = []
    @json_file = ''
  end

  def access_file
    data_file = '~/Downloads/google-10000-english-no-swears.txt'
    @file = File.open(File.expand_path(data_file), 'r')
  end

  def close_file
    file.close
  end

  def make_array
    self.array =
      file.readlines.select do |v|
        v.chomp.length > 4 && v.chomp.length < 13
      end
  end

  def json_file_a(number)
    @json_file = File.open("#{Dir.home}/programmin/repos/Hangman/data/#{number}.json", &:readline)
  end

  def save_file(data)
    # The number and path is cuz we need to name our files each time
    number = Dir.glob(File.join("#{Dir.home}/Projects/programming/Hangman", '**json')).select do |file|
      File.file?(file)
    end.count
    p number
    path = File.new("#{Dir.home}/Projects/programming/Hangman/data/#{number + 1}.json", 'w')
    File.write(path, data)
  end

  def choose_random_word
    array.sample.chomp
  end
end
