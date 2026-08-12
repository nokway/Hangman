require_relative 'file_accessor'
require_relative 'code_class'

class Game
  attr_accessor :code, :file_accessor

  def initialize
    @file_accessor = FileAccessor.new()
    @file = file_accessor.file
    @code = Code.new('e')
  end

  def start
    loop do
     
      # display code
      # ask for guess
      # compare guess
      #
    end
  end

  def check_win(code, guess)
    return false unless code == guess

    true
  end

  
end

file = Game.new.file_accessor.access_file
file.close
