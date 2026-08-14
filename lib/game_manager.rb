require_relative 'file_accessor'
require_relative 'code_class'

class Game
  attr_accessor :code, :code_maker

  def initialize
    @code_maker = FileAccessor.new
    @code = Code.new(word)
  end

  def word
    code_maker.access_file
    code_maker.make_array
    code_maker.choose_random_word
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


 game1 = Game.new


