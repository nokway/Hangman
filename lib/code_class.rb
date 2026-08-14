
# Handles code
class Code
  attr_accessor :code

  def initialize(code)
   @code = code  
  end 

  def add_underscores
    p 'Code: '
    p code
    code.split('').map { |_| '_' }
  end

  def display_code
    p code
  end


end
