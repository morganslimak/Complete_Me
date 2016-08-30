require './test/test_helper'
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

    expected = ["pizza", "pizzeria", "pizzicato", "pizzle", "pize"]

    assert_equal expected, trie.suggest("piz")
  end

  # completion.suggest("piz")
  # => ["pizza", "pizzeria", "pizzicato"]
  #
  # completion.select("piz", "pizzeria")
  #
  # completion.suggest("piz")
  # => ["pizzeria", "pizza", "pizzicato"]
  def test_select_chooses_highest_weighted_word
    trie = CompleteMe.new
    ["pizza", "pizzeria", "pizzicato", "pizzle", "pize"].each do |word|
      trie.insert(word)
    end

    trie.select("piz", "pizzle")

    assert_equal "pizzle", trie.suggest("piz").first
  end

  def test_delete_removes_word
    trie = CompleteMe.new
    ["pizza", "pizzeria", "pizzicato", "pizzle", "pize"].each do |word|
      trie.insert(word)
    end

    trie.delete("pizza")
    expected = ["pizzeria", "pizzicato", "pizzle", "pize"]

    assert_equal expected, trie.suggest("piz")
  end
end
