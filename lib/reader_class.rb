require 'pry'
require_relative 'file_accessor'

# Reader of file class
class Reader
  attr_accessor :file, :array

  def initialize(file)
    @file = file
    @array = []
  end

  def make_array
    self.array =
      file.readlines.select do |v|
        v.chomp.length > 4 && v.chomp.length < 13
      end
  end

  def choose_random_word
    array.sample.chomp
  end
end
