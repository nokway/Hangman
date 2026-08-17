require('pry')
require_relative 'file_accessor'
require_relative 'code_class'
require_relative 'serializer'
require_relative 'lives_handler'
require_relative 'input_manager'

class Game
  attr_accessor :code_manager, :file_accessor, :lives_handler, :input_manager

  def initialize
    @file_accessor = FileAccessor.new
    @code_manager = Code.new(word)
    @lives_handler = Lives.new
    @input_manager = InputManager.new
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

  def algorithmize_test
    code_manager.display_code
    p "testing, #{code_manager.code}"
    input_manager.guess_v
    code_manager.algorithmize(input_manager.guess_i)
  end

  def check_win(code, guess)
    return false unless code == guess

    true
  end

  def serialization_test
    file_accessor.save_file(Serialization.save_data(lives_handler.lives, code_manager.code, 'e'))
  end
end

game1 = Game.new
game1.algorithmize_test
