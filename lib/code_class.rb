require_relative 'selection'

# Handles code
class Code
  attr_accessor :code

  def initialize
    @code = Selection.new.choose_random_word
  end

  def add_underscores
    p 'Code: '
    p code
    code.split('').map { |_| '_' }
  end
end

p Code.new.add_underscores
