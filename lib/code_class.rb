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
    return 'Invalid word size provided, try again' if guess.size != code.size

    # Todo add handler in algorithmize function call prolly in game manager to ensure that it handles the return of the invalid message length correctly

    # TODO: ADD 1 and 2's for the handling of the values
    array1 = []
    p "testing, #{code}"
    guess.split('').each_with_index do |v, i|
      code.split('').each_with_index do |x, y|
        if v == x && i == y
          array1.push(1)
          break
        elsif v != x && i == y
          array1.push(2)
          break
        end
      end
    end
    p array1
  end
end
