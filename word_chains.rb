require 'set'

class WordChainer
  attr_reader :dictionary
  attr_accessor :current_words, :all_seen_words, :word_found

  def initialize(dictionary_file)
    @dictionary = (File.readlines(dictionary_file).map(&:chomp)).to_set
  end

  def run(source, target)
    @word_found =  false
    @current_words = [source]
    @all_seen_words = { source => nil }
    until current_words.empty?
      current_word = current_words.shift
      new_adjacent_words(current_word, target)
    end

    if !word_found
      "No chain detected."
    else
      build_path(target)
    end
  end

  def build_path(target)
    return [target] if all_seen_words[target].nil?
    prev_word = all_seen_words[target]
    build_path(prev_word) + [target]
  end


  def new_adjacent_words(current_word, target)
    new_words = adjacent_words(current_word)
    new_words.each do |new_word|
      unless all_seen_words.include?(new_word)
        all_seen_words[new_word] = current_word
        if new_word == target
          @word_found = true
          return
        end
        current_words << new_word
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
