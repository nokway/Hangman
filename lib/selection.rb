require_relative 'reader_class'

# Selects random word
class Selection
  attr_accessor :array
 
  def initialize
    @array = Reader.new.make_array   
  end

  def choose_random_word
    array.sample.chomp
  end
end


