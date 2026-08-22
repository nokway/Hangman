class Lives
  attr_accessor :lives

  def initialize
    @lives = 0
  end

  def word_life
    self.lives = 10
  end

  def display_lives
    p "Lives (you got one less): #{lives}"
  end
end
