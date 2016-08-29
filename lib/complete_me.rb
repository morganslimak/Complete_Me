require_relative 'node'
require 'pry'

class CompleteMe
  attr_accessor :root

  def initialize
    @root = Node.new("")
    @word_count = 0
  end

  def insert(word, node=@root)
    letters = word.chars
    letters.each_with_index do |letter, index|
      unless node.children.keys.include?(letter)
        node.children[letter] = Node.new(node.partial + letter)
      end
      node = node.children[letter]
      if index == word.length - 1
        node.word = true
        @word_count += 1
      end
    end
  end

  def count
    @word_count
  end

  def populate(dictionary)
    split_dictionary = dictionary.split
    split_dictionary.each do |word|
      insert(word)
    end
  end

  def suggest(user_input, node = nil, suggestions = [])
    node = reach_starting_node(user_input) if node.nil?
    node.children.each do |letter, next_node|
      suggestions.push(next_node.partial) if next_node.word
      suggest(user_input, next_node, suggestions) unless next_node.children.empty?
    end
    suggestions
  end

  def reach_starting_node(user_input, node = @root)
    letters = user_input.chars
    letters.each_with_index do |letter, index|
      node = node.children[letter]
    end
    node
  end

end
