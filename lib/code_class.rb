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

  def check_underscore
    copy = code.clone
    return false unless copy.split("").each { |v| v == '_' }

    true
  end
end

p Code.new.add_underscores
p Code.new.check_underscore
