require 'minitest/autorun'
require 'minitest/pride'
require './lib/complete_me'

class CompleteMeTest < Minitest::Test

  def test_initialized_with_empty_root_node
    trie = CompleteMe.new

    assert_equal ({}), trie.root.children
  end

  def test_insert_letter_into_trie
    trie = CompleteMe.new
    trie.insert('a')

    assert trie.root.children.has_key?('a')
  end

  def test_insert_word_into_trie
    trie = CompleteMe.new
    trie.insert('map')
    trie.insert('cat')
    trie.insert('car')

    assert_equal ["p"],
      trie.root.children['m'].children['a'].children.keys
    assert_equal ["t","r"],
      trie.root.children['c'].children['a'].children.keys
  end

  def test_count_number_of_words
    trie = CompleteMe.new
    trie.insert('map')
    trie.insert('cat')
    trie.insert('car')

    assert_equal 3, trie.count
  end

  def test_populate_trie_from_small_file
    trie = CompleteMe.new
    dictionary = File.read("./lib/words.txt")
    trie.populate(dictionary)

    assert_equal 10, trie.count
  end

  def test_populate_trie_from_full_dictionary
    skip
    trie = CompleteMe.new
    dictionary = File.read("./lib/usr/share/dict/words")
    trie.populate(dictionary)

    assert_equal 235886, trie.count
  end

  def test_navigating_to_correct_node
    trie = CompleteMe.new
    trie.insert("pizza")
    starting_node = trie.reach_starting_node("piz")

    assert starting_node.children.keys.include?("z")
  end

  def test_suggest
    trie = CompleteMe.new
    ["dog", "pizza", "pizzeria", "pizzicato", "pizzle", "pize"].each do |word|
      trie.insert(word)
    end

    assert_equal ["pizza", "pizzeria", "pizzicato", "pizzle", "pize"],
      trie.suggest("piz")
  end
end
