class Lives
  attr_accessor :lives

  def initialize
    @lives = 0
  end

  def lives_word(word_length)
    self.lives = word_length
  end
end
