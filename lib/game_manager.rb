require('pry-byebug')
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

  def play_round_rest_save(guess)
    if code_manager.algorithmize(guess) == 2
      lives_handler.lives -= 1
      lives_handler.display_lives
    end

    self.save = code_manager.total_output(guess, save)

    incorrect_letters(code_manager.algorithmize(guess), guess)
  end

  def play_save_guess(guess)
    # play_round_rest(guess)
  end

  def start
    byebug
    guess_save = save_option if file_accessor.empty_file?(@@count) == false
    round = 0

    loop do
      answer = check_save? if round != 0
      if answer
        file_accessor.save_file(Serialization.save_data(lives_handler.lives, code_manager.code, save.join('')))
        puts "Saved word: #{save}, exited successfully. "
        break
      end

      round += 1
      p save

      if guess_save.nil? # HERE (although now that i think of it, it isnt necessary cuz guess save would be blank, just have to fix that anniying error)
        play_round_guess
        guess = input_manager.guess_i
        play_round_rest(guess)
      else
        guess = play_save_guess(save)
        # Bro why is this not working arghhhhh!!!
      end

      next unless check_win(code_manager.code, save) == true

      # No winning message
      puts 'you win!'
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

    # Todo, make it so you dont have double of the same (like o, and o again in incorrect)
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
# WHY ON EARTH IS IT GETTING A NEW CODE
# BRO WHAT ON EARTH IS HAPPENING
# IF we have incorrectly guessed a letter, and therefore we can not have a save, as fill nill would give us nothing,
# then when choosing to save, self.save  becomes ''
# then if we are importing a save, all we got to do is check if the last guess is empty (which makes us know we had an incorrect guess)
# in which case we would look at all of the incorrect letters, and the lives (because one life is deducted each time)
# and then we go from there, which would probably just be asking for a new guess
