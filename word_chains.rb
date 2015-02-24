require 'set'

class WordChainer
  attr_reader :dictionary
  attr_accessor :current_words, :all_seen_words

  def initialize(dictionary_file)
    @dictionary = (File.readlines(dictionary_file).map(&:chomp)).to_set
  end

  def run(source, target)
    current_words = [source]
    all_seen_words = [source]
    until current_words.empty?
      current_word = current_words.shift
      new_words = adjacent_words(current_word)
      new_words.each do |word|
        unless all_seen_words.include?(word)
          all_seen_words << word
          current_words << word
        end
      end
    end
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
