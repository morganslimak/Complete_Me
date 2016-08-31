require "./lib/node"

class CompleteMe
  attr_accessor :root

  def initialize
    @root = Node.new
    @word_count = 0
    @word_results = Array.new
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
    letters.each do |letter|
      if node.children.include?(letter)
        node = node.children[letter]
      else
        node.children[letter] = Node.new
        node = node.children[letter]
      end
    end
    @word_count += 1
    node.word = true
  end

  def delete(word)
    node = reach_starting_node(word)
    node.word = false
    @word_count -= 1
    until word.empty?
      if node.children.empty? && node.word == false
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

  def suggest(substring)
    node = reach_starting_node(substring)
    search_children(substring, node)
    results = @word_results.map{|suffix| substring + suffix}
    @word_results = Array.new
    results
  end

  def search_children(prefix, node, suffix = "")
    @word_results << suffix if node.word?
    unless node.children.empty?
      node.children.each do |letter, node|
        new_suffix = suffix
        new_suffix += letter
        search_children(prefix, node, new_suffix)
      end
    end
  end

  def sort_words(suggestions)
    suggestions.sort! {|x, y| y.selects <=> x.selects}
    words = suggestions.map {|node| node.partial}
    words
  end

  def reach_starting_node(user_input, node = @root)
    letters = user_input.chars
    letters.each do |letter|
      node = node.children[letter]
    end
    node
  end

  def select(user_input, preferred_word)
    node = reach_starting_node(preferred_word)
    node.selects += 1
  end



end

# if node.nil?
#   node = reach_starting_node(user_input)
#   suggestions.push(node) if node.word
# end
# node.children.each do |letter, next_node|
#   suggestions.push(next_node) if next_node.word
#   unless next_node.children.empty?
#     suggest(user_input, next_node, suggestions)
#   end
# end
# sort_words(suggestions)
