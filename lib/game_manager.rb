require('pry')
require_relative 'file_accessor'
require_relative 'code_class'
require_relative 'serializer'
require_relative 'lives_handler'
require_relative 'input_manager'

# Main game handler
class Game
  attr_accessor :code_manager, :file_accessor, :lives_handler, :input_manager, :incorrect_letters_a, :save

  @@count = 0

  def initialize
    @file_accessor = FileAccessor.new
    @code_manager = Code.new(word)
    @lives_handler = Lives.new
    @input_manager = InputManager.new
    @incorrect_letters_a = []
    @save = []
    @@count += 1
  end

  def word
    file_accessor.access_file
    file_accessor.make_array
    file_accessor.choose_random_word
  end

  def save_option
    puts 'Do you want to get a  save? save / no: '
    answer = gets.chomp.downcase
    return unless answer == 'save'

    file_accessor.json_file_a(@@count)
    data = Serialization.load_data(file_accessor.json_file)
    self.save = data[:last_guess]
    lives_handler.lives = data[:lives]
    code_manager.code = data[:word]

    data[:last_guess]
  end

  def game_number_json
    @@count
  end

  def play_round_guess
    code_manager.display_code
    if lives_handler.lives.negative?
      # We simoly break in the maiin function if anything here returned false
      return false
    end

    input_manager.guess_v # return value
  end

  def play_round_rest(guess)
    if code_manager.algorithmize(guess) == 2
      lives_handler.lives -= 1
      lives_handler.display_lives
    end

    self.save = code_manager.total_output(guess, save)

    incorrect_letters(code_manager.algorithmize(guess), guess)
  end

  def play_save_guess(guess)
    play_round_rest(guess)
  end

  def start
    guess_save = save_option
    # should only do this if we have data there already
    # # We need to handle the error, so that maybe we check before hand if the file is empty as to not cause the error so that we can continue to our own chrcker labelee HERE

    loop do
      answer = check_save?
      if answer
        file_accessor.save_file(Serialization.save_data(lives_handler.lives, code_manager.code, save.join('')))
        puts 'saved and exited'
        break
      end

      if guess_save == '' # HERE (although now that i think of it, it isnt necessary)
        guess = play_round_guess
        play_round_rest(guess)
      else
        play_save_guess(guess_save)
        guess = guess_save
      end

      next unless check_win(code_manager.code, guess) == true

      # No winning message
      pits 'you win!'
      puts save
      p code_manager.code
      break
    end
  end

  def check_save?
    puts 'Do you want to save the game?'
    answer = gets.chomp.downcase
    return false unless answer == 'yes'

    true
  end

  def incorrect_letters(algorithm, guess)
    incorrect_letters_a.push(guess) if algorithm == 2
    puts "Incorrect letters: #{incorrect_letters_a.clone.map { |v| "#{v} " }}"

    # Todo, make it so you dont have double of the same
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

# TODO, FIX THE SAVING SO THAT IT LOADS PROPERLY< BASICALLY, LOAD NORMAL GUESS AND PLAY NORMALLY UNLESS YOU HAVE LOADED FROM THE SAVE, WHICH WE HAVE ALREADY HANDLED
