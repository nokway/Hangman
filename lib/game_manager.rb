require('pry-byebug')
require_relative 'file_accessor'
require_relative 'code_class'
require_relative 'serializer'
require_relative 'lives_handler'
require_relative 'input_manager'

# Main game handler
class Game
  attr_accessor :code_manager, :file_accessor, :lives_handler, :input_manager, :incorrect_letters_a, :save, :redo_guess

  @@count = 0

  def initialize
    @file_accessor = FileAccessor.new
    @code_manager = Code.new(word)
    @lives_handler = Lives.new
    @input_manager = InputManager.new
    @incorrect_letters_a = []
    @save = []
    @@count += 1
    @redo_guess = 'no'
  end

  def word
    file_accessor.access_file
    file_accessor.make_array
    file_accessor.choose_random_word
  end

  def get_save # rubocop:disable Naming/AccessorMethodName
    puts 'Do you want to get a  save? yes / no: '
    answer = gets.chomp.downcase
    return unless answer == 'yes'

    file_accessor.json_file_a(@@count) # Gets the json data file and read lines
    data = Serialization.load_data(file_accessor.json_file) # Parses it in the serializer
    self.save = data['last_guess']
    lives_handler.lives = data['lives']
    code_manager.code = data['word']
    self.incorrect_letters_a = data['incorrect_array']

    return unless check_win(code_manager.code, save) == true

    'won already'
  end

  def game_number_json
    @@count
  end

  def play_round_guess
    if [[], ''].include?(save)
      code_manager.display_code
    else
      p save
    end
    p incorrect_letters_a

    # if lives_handler.lives.negative?
    #   # We simoly break in the maiin function if anything here returned false
    #   return false
    # end
    input_manager.guess_v # return value
  end

  def decrement(guess)
    return unless code_manager.algorithmize(guess) == 2

    lives_handler.lives -= 1
    lives_handler.display_lives
  end

  def play_round_rest(guess)
    decrement(guess)
    self.save = code_manager.total_output(guess, save)

    return '2' if incorrect_letters(code_manager.algorithmize(guess), guess) != 'yes'

    incorrect_letters(code_manager.algorithmize(guess), guess)
  end

  def play_round_rest_save(guess)
    self.save = code_manager.total_output(guess, save) # Get a new guess
  end

  def start
    byebug
    guess_save = get_save if file_accessor.empty_file?(@@count) == false
    round = 0

    loop do
      if guess_save == 'won already'
        puts 'you win!'
        puts save
        p code_manager.code
        break
      end
      answer = save_game? if round != 0 && redo_guess == 'no'
      if answer
        file_accessor.save_file(Serialization.save_data(lives_handler.lives, code_manager.code, save.join(''),
                                                        incorrect_letters_a))
        puts "Saved word: #{save}, exited successfully. "
        break
      end

      round += 1 if redo_guess == 'no'

      play_round_guess
      guess = input_manager.guess_i

      redo if play_round_rest(guess) == '2'

      self.redo_guess = 'no'

      next unless check_win(code_manager.code, save) == true

      if incorrect_letters_a.length == code_manager.code.length
        p 'You lost, insufficient amount of lives'
        p "Lives: #{lives_handler.lives}"
        break
      end

      puts 'you win!'
      puts save
      p code_manager.code
      break
    end
  end

  def save_game?
    puts 'Do you want to save the game?'
    answer = gets.chomp.downcase
    return false unless answer == 'yes'

    true
  end

  def incorrect_letters(algorithm, guess)
    if incorrect_letters_a.include?(guess)
      p 'Already guessed that, try again'
      self.redo_guess = 'yes'
    else
      incorrect_letters_a.push(guess) if algorithm == 2
      puts "Incorrect letters: #{incorrect_letters_a.clone.map { |v| "#{v} " }}"
      'yes'
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
game1.start

# THINGS I HAVE DONE
# So essentially we realized that save would save the previous state of a game, meaning we can start a new round,
# problem is that when we have only guessed incorrectly and we decide to save the game
# we would have no knowledge of the previous incorrectly saves stuff, so what we can do is
# we can print the incorrect guess array and save it from last time beasically (the only thing we would use from the last time maybe)
# and then maybe do some check to ensure we dont have the same incorrect letters again, handle a checker for that
# and then we are good, because we would have imported the amount of lives correctly and therefore we also need to implement a feature
# so that when a certain negative amount of lives have been reached or incorrect letters length == code lenggth then  it is game over
#
#
#
# Another idea we could have an instance variable called win game, and set it to true if certain values are met, this way we could check if we won the game in the beginnning (maybe)

# TODO:
# fix that weird error when you are saving game, the normal mode should work as intended, goos job!
