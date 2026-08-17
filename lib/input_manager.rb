class InputManager
  attr_accessor :guess_i

  def initialize
    @guess_i = ''
  end

  def guess_v
    self.guess_i = gets.chomp
  end
end
