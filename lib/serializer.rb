# frozen_string_literal: true

require 'json'

class Serialization # rubocop:disable Style/Documentation
  def self.save_data(lives, word, last_guess, incorrect_letters)
    JSON.generate({
                    lives: lives,
                    word: word,
                    last_guess: last_guess,
                    incorrect_letters: incorrect_letters
                  })
  end

  def self.load_data(json_obj)
    JSON.parse(json_obj)
  end
end
