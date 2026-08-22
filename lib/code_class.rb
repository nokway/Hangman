# frozen_string_literal: true

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

  def fill_nill(save)
    save_clone = save.clone
    save_clone.each_with_index do |v, i|
      p v.nil?
      save_clone[i] == '_ ' if v.nil?
    end
    p save_clone
    save_clone
  end

  def missing_values(guess, save)
    # Here we assume that the guess was present in the word
    code_clone = code.clone.split('')
    code_clone.each_with_index do |v, i|
      save[i] = v if v == guess
    end

    save
  end

  def total_output(guess, save)
    fill_nill(missing_values(guess, save))
  end
end
