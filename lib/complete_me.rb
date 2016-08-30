require_relative 'node'

class CompleteMe
  attr_accessor :root

  def initialize
    @root = Node.new("")
    @word_count = 0
  end

  def insert(words)
    if words.class == Array
      words.each do |word|
        insert_a_word(word)
      end
    else
      insert_a_word(words)
    end
  end

  def insert_a_word(word, node=@root)
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

  def delete(word)
    node = reach_starting_node(word)
    node.word = false
    @word_count -= 1
    until word.empty?
      if node.children.empty?
        saved_letter = word.chars.last
        word = word.chop
        node = reach_starting_node(word)
        node.children.delete(saved_letter)
      else
        break
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
    if node.nil?
      node = reach_starting_node(user_input)
      suggestions.push(node) if node.word
    end
    node.children.each do |letter, next_node|
      suggestions.push(next_node) if next_node.word
      suggest(user_input, next_node, suggestions) unless next_node.children.empty?
    end
    sort_words(suggestions)
  end

  def sort_words(suggestions)
    suggestions.sort! {|x, y| y.selects <=> x.selects}
    words = suggestions.map {|node| node.partial}
    words
  end

  def reach_starting_node(user_input, node = @root)
    letters = user_input.chars
    letters.each_with_index do |letter, index|
      node = node.children[letter]
    end
    node
  end

  def select(user_input, preferred_word)
    node = reach_starting_node(preferred_word)
    node.selects += 1
  end

end
