
# Handles code
class Code
  attr_accessor :code

  def initialize(code)
   @code = code  
  end 

  def add_all_underscores
    p 'Code: '
    p code
    code.split('').map { |_| '_' }
  end

  def algorithmize(guess)
    # TODO ADD 1 and 2's for the handling of the values'
  end



end
