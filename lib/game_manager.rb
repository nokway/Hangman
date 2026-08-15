require_relative 'file_accessor'
require_relative 'code_class'
require_relative 'serializer'
require_relative 'lives_handler'

class Game
  attr_accessor :code, :file_accessor, :lives_handler

  def initialize
    @file_accessor = FileAccessor.new
    @code = Code.new(word)
    @lives_handler = Lives.new
  end

  def word
    file_accessor.access_file
    file_accessor.make_array
    file_accessor.choose_random_word
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

  def serialization_test
    file_accessor.save_file(Serialization.save_data(lives_handler.lives, code.code, 'e'))
  end
end

game1 = Game.new
game1.serialization_test
