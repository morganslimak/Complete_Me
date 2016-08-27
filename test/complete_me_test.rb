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

end
