# Handles code
class Code
  attr_accessor :code

  def initialize(code)
    @code = code
  end

  def display_code
    copy = code.clone
    p(copy.split('').map { |_| '_' })
  end

  def algorithmize(guess)
    copy = code.clone.split('')
    return false if guess.size != 1

    if copy.include?(guess)
      1
    else
      2
    end
  end
end
