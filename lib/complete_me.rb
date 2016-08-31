require "./lib/node"

class CompleteMe
  attr_accessor :root

  def initialize
    @root = Node.new
    @word_count = 0
    @suggestions = Array.new
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
    search_children(node)
    results = @suggestions.map{|suffix| substring + suffix}
    @suggestions = Array.new
    sort_words(results)
  end

  def search_children(node, suffix = "")
    @suggestions << suffix if node.word
    unless node.children.empty?
      node.children.each do |letter, node|
        suffix_step = suffix
        suffix_step += letter
        search_children(node, suffix_step)
      end
    end
  end

  def sort_words(results)
    times_selected = obtain_selects_number(results)
    combined = results.zip(times_selected)
    with_selects = Array.new
    without_selects = Array.new
    combined.each do |word|
      if word.last > 0
        with_selects << word
      else
        without_selects << word
      end
    end
    output = with_selects.sort_by{|word| word.last}
    output += without_selects
    output.map{|word| word.first}
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

  private
  def obtain_selects_number(words)
    times_selected = words.map do |word|
      node = reach_starting_node(word)
      node.selects
    end
  end

end
