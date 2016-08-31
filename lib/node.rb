class Node
  attr_accessor :children, :word, :selects

  def initialize
    @word = false
    @children = Hash.new
    @selects = 0
  end

end
