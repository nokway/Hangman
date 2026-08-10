require_relative 'reader_class'

class Selection
  attr_accessor :array
 
  def initialize
    @array = Reader.new.make_array   
  end

  def choose_random_word
    array.sample.chomp
  end
end

p Selection.new.choose_random_word
