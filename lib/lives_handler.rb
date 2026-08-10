class Lives
  attr_accessor :lives

  def initialize
    @lives = 0
  end

  def set_lives(word_length)
    self.lives = word_length
  end
end
