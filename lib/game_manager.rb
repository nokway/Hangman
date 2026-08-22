require('pry')
require_relative 'file_accessor'
require_relative 'code_class'
require_relative 'serializer'
require_relative 'lives_handler'
require_relative 'input_manager'

# Main game handler
class Game
  attr_accessor :code_manager, :file_accessor, :lives_handler, :input_manager, :incorrect_letters_a

  def initialize
    @file_accessor = FileAccessor.new
    @code_manager = Code.new(word)
    @lives_handler = Lives.new
    @input_manager = InputManager.new
    @incorrect_letters_a = []
  end

  def word
    file_accessor.access_file
    file_accessor.make_array
    file_accessor.choose_random_word
  end

  def start
    code_manager.display_code
    loop do
      guess = input_manager.guess_v
      next unless check_win(code_manager.code, guess) == false

      lives_handler.lives -= 1

      break if code_manager.algorithmize(guess) == false

      incorrect_letters(code_manager.algorithmize(guess), guess)
    end
  end

  def incorrect_letters(algorithm, guess)
    incorrect_letters_a.push(guess) if algorithm == 2
    puts "Incorrect letters: #{incorrect_letters_a.clone.map { |v| "#{v} " }}"
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
game1.start
