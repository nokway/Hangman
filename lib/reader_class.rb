require 'pry'
require_relative 'io_creator'

# Reader of file class
class Reader
  attr_accessor :file

  def initialize
    @file = AcessFile.new.file
  end

  def make_array
    array =
      file.readlines.select do |v|
        v.chomp.length > 4 && v.chomp.length < 13
      end
    @file.close
    array
  end
end
