require 'set'

class WordChainer
  attr_reader :dictionary

  def initialize(dictionary_file)
    @dictionary = (File.readlines(dictionary_file).map(&:chomp)).to_set
  end

  def adjacent_words(word)
    adj_words = []

    word.split("").each_with_index do |char, idx|
      ('a'..'z').each do |new_char|
        next if char == new_char
        new_word = word.dup
        new_word[idx] = new_char
        adj_words << new_word if dictionary.include?(new_word)
      end
    end

    adj_words
  end


end
