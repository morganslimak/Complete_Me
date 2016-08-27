require 'minitest/autorun'
require 'minitest/pride'
require './lib/node'

class NodeTest < Minitest::Test
  def test_create_a_node_with_empty_children_hash
    node = Node.new
    assert_equal ({}), node.children
  end

end
